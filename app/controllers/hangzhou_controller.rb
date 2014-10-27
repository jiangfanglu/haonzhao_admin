# encoding: UTF-8
class HangzhouController < ApplicationController
  skip_before_filter  :verify_authenticity_token
  # XML报文方法开始 =======================================
  def importorder
    #@orders = Order.includes(:order_products).includes(:hz_order).where("order_id in (?)",params[:oids].split(","))
  end
  def company_applied
    #@company = HzCompany.find params[:cid]
  end
  def personal_goods_declare
  	 #@orders = Order.includes(:order_products).includes(:hz_order).where("order_id in (?)",params[:oids])
  end
  def productapplication
    #@products = Product.includes(:shop).includes(:product_description).includes(:hz_product).where("product_id in (109,107)")
  end
  def order_return
  end
  # XML报文方法结束 =======================================

  # 列表清单开始 ==============================
  def products
    @products = Product.includes(:product_description).includes(:hz_product).order('product_id DESC').paginate page: params[:page], per_page: 20
  end
  def orders
    @orders = Order.includes(:hz_order).includes(:order_status).where("hz_orders.approve_result <> '1' or hz_orders.approve_result is null").order('oc_order.order_id DESC').paginate page: params[:page], per_page: 20
  end
  def personals
    @orders = Order.includes(:hz_order).includes(:order_status).where("hz_orders.pg_result <> '1' or hz_orders.pg_result is null").order('oc_order.order_id DESC').references(:hz_order).paginate page: params[:page], per_page: 20
  end
  # 列表清单结束 ==============================

  # 申报接口方法开始 ===================================
  def apply_for_product_record
    @products = Product.includes(:product_description).includes(:hz_product).where("oc_product.product_id in (?)",params[:tick])
    @products.each do |product|
      response = post_to_interface(product_xml(product), "PRODUCT_RECORD")
      product.hz_product.update_attributes(
        approve_result: response[0], 
        approve_comment: response[1], 
        process_time: response[2] 
      ) if response[0].to_i == 1
    end
    render :text=>"OK",:layout=>false
  end

  def apply_for_order_record
    @orders = Order.includes(:order_products).includes(:hz_order).where("order_id in (?)",params[:tick])
    @orders.each do |order|
      response = post_to_interface(order_xml(order), "IMPORTORDER")
      order.hz_order.update_attributes(
        approve_result: response[0], 
        approve_comment: response[1], 
        process_time: response[2] 
      ) if response[0].to_i == 1
    end
    render :text=>"OK",:layout=>false
  end

  def add_importorder_return
    @orders = Order.includes(:order_products).includes(:hz_order).where("order_id in (?)",params[:tick])
    s = render_to_string :file => 'hangzhou/order_return.xml'
    response = post_to_interface(s, "IMPORT_ORDER_RETURN")
    p response.body
    render :text=>"OK",:layout=>false
  end

  def individual_product_apply
    @orderids = params[:order_info][:order_ids].split(",")
    @orders = Order.includes(:order_products).includes(:hz_order).where("order_id in (?)",@orderids)
    @orders.each do |order|
      order.hz_order.update_attributes(
          ie_port: params[:order_info][:ie_port],
          customs_field: params[:order_info][:custom_field],
          tranf_mode: params[:order_info][:tranf_mode],
          destination_port: params[:order_info][:destination_port],
          decl_port: params[:order_info][:decl_port],
          entering_person: params[:order_info][:entering_person],
          sender_city: params[:order_info][:sender_city]
        )
      
      response = post_to_interface(personal_goods_xml(order), "PERSONAL_GOODS_DECLAR")
      order.hz_order.update_attributes(
          pg_result: response[0], 
          pg_comment: response[1], 
          pg_time: response[2] 
        ) if response[0].to_i == 1
    end
    render :text=>"OK",:layout=>false
  end

  def apply_for_company_record
    @company = HzCompany.find params[:id]
    s = render_to_string :file => 'hangzhou/company_applied.xml'
    filename = "JKF_1SHOO_IMPORT_COMPANY_1_#{@company.id}_#{Time.new.strftime('%Y%m%d%H%M%S')}"
    File.open("#{Rails.root}/public/beian/companies/#{filename}.xml",'w'){|f| f.write s}
    response = post_to_interface(s, "IMPORT_COMPANY")
    render :json => { :success => true, :html => "OK" },:layout=>false
  end
  # 申报接口方法结束 ===================================

  # 调用接口函数
  def post_to_interface content, business_type
    client = Savon.client(wsdl: HZ_RECORD_URL)
    begin
      response = client.call(:check_received, :message=> {:xmlStr => content, :xmlType => business_type, :sourceType => '1'})
    rescue Savon::Error => soap_fault
      print soap_fault.http.body
    end
    doc = Nokogiri::XML(response.body[:check_received_response][:return])
    record_status = doc.at_css("body list jkfResult chkMark").content
    #record_comment = doc.at_css("body list jkfResult note").content
    record_time = "#{doc.at_css("body list jkfResult noticeDate").content} #{doc.at_css("body list jkfResult noticeTime").content}".to_datetime
    return [record_status,"",record_time]
  end

  # 添加订单重量与包装方式表单
  def add_order_info
    @packages = HzPackage.all
    @hz_order = HzOrder.includes(:hz_way_bills).find_by_order_id params[:orderid]
    render :layout=>false
  end

  # 个人物品申报附加信息表单
  def apply_personal_goods_form
    @transports = HzTransport.all
    render :layout=>false
  end


  def save_order_extra_info
    @hz_order = HzOrder.find_by_order_id params[:orderid]
    @hz_order = HzOrder.new if @hz_order.blank?
    @hz_order.order_id = params[:orderid] if @hz_order.order_id.blank?
    @hz_order.package_type = params[:package_type]
    @hz_order.gross_weight = params[:gross_weight].to_f
    HzWayBill.delete_all("order_id = #{params[:orderid]}")
    way_bill_nos = params[:way_bills].split(",")
    way_bill_nos.each do |way_bill_no|
      @hz_order.hz_way_bills << HzWayBill.new(
        way_bill_no: way_bill_no,
        order_id: @hz_order.order_id
        ) 
    end
    @hz_order.save
    render :text => "OK", :layout=>false
  end

  # 接受电子口回执处理服务端接口
  def hz_record_result
    # 还原报文
    content = Base64.decode64(params[:content])
    key = Base64.decode64(AES_PRIVATE_KEY)
    decrypted_data = AESCrypt.decrypt_data(content, key, nil, "AES-128-ECB")
    
    # 判断报文回执类别
    doc = Nokogiri::XML(decrypted_data)
    business_type = doc.at_css("head businessType").content.strip

    case business_type
    when "RESULT" # 普通异步回执
      save_result doc
    when "PERSONAL_GOODS_DECLAR" # 个人物品申报单审批回执
      save_personal_good_result doc
    when "TAXISNEED" # 是否应收税款回执
      save_taxineed_result doc
    when "IMPORTBILLRESULT" #运单出区回执
      save_importbill_result doc
    else
      unprocessed_result = HzUnprocessedResult.new
      unprocessed_result.content = decrypted_data
      unprocessed_result.save
    end    

    render :text => text, :layout=>false
  end

#"content"=>"v66YKULHFld2JElhm/J9qik2Edr1JHdZIc/k/OesU2GbTX2usXyvF4jGvzvoihrrE8FsfKmllmjsMIjO5fdrS/FD20bYFii4JW3BO3bzshXHyHKLIl2B8y90AfbLu4dnqIh/3IlDZ6aJG58ShqB7ZM0C+n61FVamNzdPjKUGtF5cUHEy1ebMDIe0jFloITh/wGLn6YwujEiYK4Xd5yzI2BpjNSnNqac3gTCf1V9j+oTCBvEQkWiZCA71Gl4wRJsFaNqdjvCnziDF2DfcQEIB+Zqi38j9yZ55ymJY32eDk85nWm4/iCnnjwhY2qCrbrCEZAwJjw8NZSEdORoxKrGnzScR/wdpmgTS+uOhokUW6IGX5ns0ibADs0b8SB+dZY0sghAsfNWBtzW7IPQQoTjjVK7mZok4wPNWvv325k8lOb+e0NiUINnxHaKchDS8EWFwZixkRVV1CDgS/pTa9FXe7mAr1y5TsRrlmA9/kF/82J15rKqqw53TKvTYe1SIlbrlxDPQ3yN8ksCN+2k7Y+o8KWBPVIi1xlG1n/ssdDftuSauHeEqoOhNuO1i6uuehVhEQ8bxJ6XUL78rAkHvmP1iCSTX3u2cBvhnWWIfB4AJykAoYE1tSo/T1W3avyUYw8bEhl5wDrnUzioo0hNcOEMOeQybAowilX6KZ9PNnVmnbME0b8tXrzrE0i0iCi8kLy0oMm8gl5KwhnNP8gT+YhGyUkdxBwS9aUMgEAFlZ2CAKeYj4EnlAn25aVTwh0xyIISMHt+37JVRIlIy4DoJk7lQzwWZQR68365GKdvomZHwqgUOiMcHFyqU5bfsGbgytwT3t4YjIOWjBAafQUNFAJhOzj9w4NSPrU7gZQcklxDxBLT5ZE+SOilhDZjlGi+D2LzaepBzyVZZ793LNioWSNWtcvc1OHtW6Dr4gtzOqKogAGi3/0zIyPzFQ4uXyNx2p3nOOVf/3fgtS44UFZiStiS4w/hMaCV4giRB7ovYMZ6I962Yy3MsAiLnViGsNPy4n5Mf2G0kFyQg8fe3je1CzdUELTBAEU5ZjWbRvxcpPdVrOz7stRqyxM/DBsVPiTf3o5jKk4e/kFu2DblOm3h3VhMOwlGHagt4oddsxHVb6xKAh2M=", "msg_type"=>"CUSTOMS_DECLARE_RESULT_CALLBACK", "data_digest"=>"jpLVxJ60FQqG+b6/6DdptbtAFKduAr2RoqMIOS1SK14GNSjYsjv+xMHYZOJ6dDLVvCcYUHMZdyjgwT94jPjCwObxBJp0fAmGWksYXAaMl4gD0cdjQSIwkFUbzxMqfsHJ6FTigre4MY45mgWVWL2HIT9LR5Y0fPQBNKuyj1Xm8SE="

  def ws_test
    # key = "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCffOeIVYut9jW5w1L5uKX4aDvd837a8JhaWm5S8YqNQfgEmfD9T+rDknXLqMT+DXeQAqGo4hBmcbej1aoMzn6hIJHk3/TfTAToNN8fgwDotHewsTCBbVkQWtDTby3GouWToVsRi1i/A0Vfb0+xM8MnF46DdhhrnZrycERBSbyrcwIDAQAB"
    # input_data = content.force_encoding("utf-8")
    # public_key = Base64.decode64(key)
    # rsa_public_key = OpenSSL::PKey::RSA.new(public_key,decrypted_data)
    # text = rsa_public_key.public_decrypt(input_data)
    
    #text = Base64.encode64(Digest::MD5.hexdigest(decrypted_data+"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCffOeIVYut9jW5w1L5uKX4aDvd837a8JhaWm5S8YqNQfgEmfD9T+rDknXLqMT+DXeQAqGo4hBmcbej1aoMzn6hIJHk3/TfTAToNN8fgwDotHewsTCBbVkQWtDTby3GouWToVsRi1i/A0Vfb0+xM8MnF46DdhhrnZrycERBSbyrcwIDAQAB")).strip
    
    #@product = Product.includes(:product_description).includes(:hz_product).find 107
    xml = "<?xml version=\"1.0\" encoding=\"UTF-8\" ?><mo version=\"1.0.0\"><head><businessType>RESULT</businessType></head><body><list><jkfResult><companyCode>1234567890</companyCode><businessNo>6751406356998</businessNo><businessType>PERSONAL_GOODS_DECLAR</businessType><declareType>1</declareType><chkMark>1</chkMark><noticeDate>2014-10-27</noticeDate><noticeTime>09:47</noticeTime><resultList><jkfResultDetail><resultInfo>处理成功</resultInfo></jkfResultDetail></resultList></jkfResult></list></body></mo>"
    render :xml => xml, :layout=>false
  end

  private
    # 报文XML模板开始 ===========================================

    # 写入文件
    #filename = "JKF_1SHOO_IMPORTORDER_1_#{@orders.first.order_sn}_#{Time.new.strftime('%Y%m%d%H%M%S')}"
    #File.open("#{Rails.root}/public/beian/orders/#{filename}.xml",'w'){|f| f.write s}

    def product_xml product
      @output = ""
      xml = Builder::XmlMarkup.new(:target => @output, :ident => 1)
      xml.instruct! :xml, :encoding => "UTF-8",  :version => "1.0"
      xml.mo(:version=>"1.0.0") do
        xml.head do
          xml.businessType("PRODUCT_RECORD")
        end
        xml.body do
          xml.productRecordList do
            #@products.each do |product|
              xml.productRecord do
                xml.jkfSign do
                  xml.companyCode(HZ_COMPANY_CODE)
                  xml.businessNo(@product.product_id)
                  xml.businessType("PRODUCT_RECORD")
                  xml.declareType("1")
                  xml.note("")
                end
                xml.productRecordDto do
                  xml.companyCode(HZ_COMPANY_NO) #电商平台备案取得的唯一标示
                  xml.companyName(HZ_COMPANY_NAME)
                  xml.postTaxNo(@product.hz_product.post_tax_no) #海关10位行邮税号, 见参数表
                  xml.goodsType(@product.hz_product.hz_post_tax.item_category)
                  xml.goodsName(@product.product_description.name)
                  xml.barCode(@product.hz_product.barcode) #optional
                  xml.brand(@product.shop.name) #optional
                  xml.goodsModel(@product.model) #optional
                  xml.mainElement(@product.hz_product.main_elements) #optional
                  xml.purpose(@product.hz_product.hz_purpose_code) #optional
                  xml.standards(@product.hz_product.standard) #optional
                  xml.productionEnterprise(@product.shop.name) #optional
                  xml.productionCountry(@product.shop.hz_manufacturer.hz_country.code) #optional
                  xml.licenceKey("") #optional
                  xml.categoryCode("1234567890") #optional
                  xml.materialAddress(@product.hz_product.material_address) #指国检要求提交的产品备案材料，此处指材料的片地址, optional
                  xml.declareTimeStr(Time.new.strftime("%Y-%m-%d %H:%M:%S")) ##optional yyyy-MM-dd HH:mm:ss
                end
              end
            #end
          end
        end
      end
      @output
    end

    def order_xml order
      @output = ""
      xml = Builder::XmlMarkup.new(:target => @output, :ident => 1)
      xml.instruct! :xml, :encoding => "UTF-8",  :version => "1.0"
      xml.mo(:version=>"1.0.0") do
        xml.head do
          xml.businessType("IMPORTORDER")
        end
        xml.body do
          xml.orderInfoList do
            #@orders.each do |order|
              xml.orderInfo do
                xml.jkfSign do
                  xml.companyCode(HZ_COMPANY_NO)
                  xml.businessNo(order.order_sn) #order number
                  xml.businessType("IMPORTORDER")
                  xml.declareType("1")
                  xml.note("") #optional
                end
                xml.jkfOrderImportHead do
                  xml.eCommerceCode(HZ_ECOMMERCE_COMPANY_NO)
                  xml.eCommerceName(HZ_ECOMMERCE_COMPANY_NAME)
                  xml.ieFlag("I")
                  xml.payType(order.hz_order.pay_type)
                  xml.payCompanyCode(order.hz_order.pay_company_code)
                  xml.payNumber(order.hz_order.pay_number)
                  xml.orderTotalAmount(order.total)
                  xml.orderNo(order.order_sn)
                  xml.orderTaxAmount(order.order_totals.where("code = 'tax'").sum("value").to_f) #according to goods amount, can be 0
                  xml.orderGoodsAmount(order.order_totals.where("code = 'sub_total'").sum("value").to_f) 
                  xml.feeAmount(order.order_totals.where("code = 'shipping'").sum("value").to_f) #can be 0, optional
                  xml.companyName(HZ_COMPANY_NO)
                  xml.companyCode(HZ_ECOMMERCE_COMPANY_NO)
                  xml.tradeTime(order.date_added.strftime("%Y-%m-%d %H:%M:%S")) #格式：2014-02-18 20:33:33
                  xml.currCode(order.hz_order.currency_code) #见参数表
                  xml.totalAmount(order.total)
                  xml.consigneeEmail(order.email)
                  xml.consigneeTel(order.telephone)
                  xml.consignee(order.firstname)
                  xml.consigneeAddress("#{order.shipping_country}#{order.shipping_zone}#{order.shipping_city}#{order.shipping_address_1}")
                  xml.totalCount(order.order_products.sum("oc_order_product.quantity"))
                  xml.postMode(order.hz_order.post_mode) #见参数表
                  xml.senderCountry(order.hz_order.sender_country) #见参数表
                  xml.senderName(order.hz_order.sender_name)
                  xml.purchaserId(order.customer_id)
                  xml.logisCompanyName(order.hz_order.logistic_company_name)
                  xml.logisCompanyCode(order.hz_order.logistic_company_code)
                  xml.zipCode(order.shipping_postcode) #optional
                  xml.note("") #optional
                  xml.wayBills(order.hz_order.way_bills) #optional
                end
                xml.jkfOrderDetailList do
                  n = 1
                  order.order_products.each do |order_product|
                    xml.jkfOrderDetail do 
                      xml.goodsOrder(n)
                      xml.goodsName(order_product.name)
                      xml.goodsModel(order_product.model) #optional
                      xml.codeTs(order_product.product.hz_product.blank? ? "" : order_product.product.hz_product.post_tax_no) #必须已备案，且与 参数说明文档中的行邮税号 中的税号一致
                                  xml.grossWeight(order_product.product.weight) #optional
                                  xml.unitPrice(order_product.price)
                                  xml.goodsUnit(order_product.product.hz_product.blank? ? "" : order_product.product.hz_product.unit_code) #见参数表
                                  xml.goodsCount(order_product.quantity)
                      xml.originCountry(order_product.product.shop.hz_manufacturer.hz_country_code) #见参数表
                    end
                    n += 1
                  end
                end
                xml.jkfGoodsPurchaser do
                  xml.id(order.customer_id)
                  xml.name(order.firstname)
                  xml.email(order.email) #optional
                  xml.telNumber(order.telephone)
                  xml.address("#{order.shipping_country}#{order.shipping_zone}#{order.shipping_city}#{order.shipping_address_1}")
                  xml.paperType(order.customer.user.blank? ? "" : "0"+order.customer.user.customer_identifications.where("identification_type = '1'").first.identification_type.to_s) 
                            xml.paperNumber(order.customer.user.blank? ? "" : order.customer.user.customer_identifications.where("identification_type = '1'").first.identification_no)
                end
              end
            #end
          end
        end  
      end
      @output
    end
    def personal_goods_xml order
      @output = ""
      xml = Builder::XmlMarkup.new(:target => @output, :ident => 1)
      xml.instruct! :xml, :encoding => "UTF-8",  :version => "1.0"
      xml.mo(:version=>"1.0.0") do
        xml.head do
          xml.businessType("PERSONAL_GOODS_DECLAR")
        end
        xml.body do
          xml.goodsDeclareModuleList do
            #@orders.each do |order|
              xml.goodsDeclareModule do
                xml.jkfSign do
                  xml.companyCode(HZ_COMPANY_NO)
                  xml.businessNo(order.order_sn)
                  xml.businessType("PERSONAL_GOODS_DECLAR")
                  xml.declareType("1")
                  xml.note("") #can be null
                end
                xml.goodsDeclare do
                  xml.accountBookNo("") #optional
                  xml.ieFlag("I")
                  xml.preEntryNumber("预录入号码")
                  xml.importType("0") #0：一般进口, 1：保税进口
                  xml.inOutDateStr("") #格式：2014-02-18 20:33:33
                  xml.iePort(order.hz_order.ie_port) #见参数表
                  xml.destinationPort(order.hz_order.destination_port) #见参数表
                  xml.trafName("运输工具名称") #包括字母和数字.可以填写中文.转关时填写@+16位转关单号. optional
                  xml.voyageNo("运输工具航次(班)号") #新增，包括字母和数字，可以有中文. optional
                  xml.trafMode(order.hz_order.tranf_mode) #参照运输方式代码表(TRANSF)
                  xml.declareCompanyType("个人委托电商企业申报") #个人委托电商企业申报;个人委托物流企业申报;个人委托第三方申报
                  xml.declareCompanyCode(HZ_COMPANY_NO) #指委托申报单位代码
                  xml.declareCompanyName(HZ_COMPANY_NAME) #指委托申报单位名称
                  xml.eCommerceCode(HZ_ECOMMERCE_COMPANY_NO) 
                  xml.eCommerceName(HZ_ECOMMERCE_COMPANY_NAME)
                  xml.orderNo(order.order_sn)
                  xml.wayBill(order.hz_way_bills.collect{|wb| wb.way_bill_no}.join(","))
                  xml.tradeCountry(order.shop.hz_manufacturer.hz_country_code) #参照国别代码表(COUNTRY)
                  xml.packNo(order.order_products.sum("oc_order_product.quantity")) #只能有数字
                  xml.grossWeight(order.hz_order.gross_weight) 
                  xml.netWeight("") #optional
                  xml.warpType(order.hz_order.package_type) #参照包装种类代码表
                  xml.remark("") #optional
                  xml.declPort(order.hz_order.decl_port) #对应参数表
                  xml.enteringPerson(order.hz_order.entering_person) #默认9999
                  xml.enteringCompanyName(HZ_COMPANY_NAME) #默认9999
                  xml.declarantNo("") #optional
                  xml.customsField(order.hz_order.customs_field) #对应参数表
                  xml.senderName(order.hz_order.sender_name)
                  xml.consignee(order.firstname)
                  xml.senderCountry(order.hz_order.sender_country) #参数表
                  xml.senderCity(order.hz_order.sender_city)
                  xml.paperType(order.customer.user.customer_identifications.where("identification_type = '1'").first.identification_type.to_s) #身份证（试点时期）
                  xml.paperNumber(order.customer.user.customer_identifications.where("identification_type = '1'").first.identification_no)
                  #xml.paperType("") #身份证（试点时期）
                  #xml.paperNumber("")
                  xml.worth(order.total) #只有数字，表体所有商品成交总价的和
                  xml.currCode(order.hz_order.currency_code)  #对应参数表
                  xml.mainGName(order.order_products.collect{|t| t.name}.join(","))  #可以数字和字母或者中文
                  xml.internalAreaCompanyNo("") #optional
                  xml.internalAreaCompanyName("") #optional
                  xml.applicationFormNo("") #optional
                  xml.isAuthorize("1")
                end
                xml.goodsDeclareDetails do
                  order.order_products.each do |product|
                    xml.goodsDeclareDetail do
                      xml.goodsOrder(product.product_id)
                      xml.codeTs(product.product.hz_product.post_tax_no)
                      xml.goodsItemNo(product.product_id)
                      xml.goodsName(product.name)
                      xml.goodsModel(product.model)
                      xml.originCountry(product.product.shop.hz_manufacturer.hz_country_code) #参照国别代码表(COUNTRY)
                      xml.tradeCurr(order.hz_order.currency_code) #参照币制代码表(CURR)
                      xml.tradeTotal(order.total) 
                      xml.declPrice(product.price)
                      xml.declTotalPrice(product.price*product.quantity)
                      xml.useTo(product.hz_product.hz_purpose_code) #参照用途代码表
                      xml.declareCount(product.quantity)
                      xml.goodsUnit(product.hz_product.unit_code) #参照计量单位代码表(UNIT)
                      xml.goodsGrossWeight(product.product.weight) #optional
                      xml.firstUnit(product.hz_product.unit_code) #optional
                      xml.firstCount(product.quantity) #optional
                      xml.secondUnit("") #optional
                      xml.secondCount("") #optional
                      xml.productRecordNo(product.hz_product.record_code) #通过向国检备案获取
                      xml.webSite(product.hz_product.url) #optional
                    end
                  end
                end
              end
            #end
          end
        end
      end
      @output
    end
    def order_return_xml order
      @output = ""
      xml = Builder::XmlMarkup.new(:target => @output, :ident => 1)
      xml.instruct! :xml, :encoding => "UTF-8",  :version => "1.0"
      xml.mo(:version=>"1.0.0") do
        xml.head do
          xml.businessType("IMPORT_ORDER_RETURN")
        end
        xml.body do
          xml.goodsReturnModuleList do
            #@orders.each do |order|
              xml.goodsReturnModule do
                xml.jkfSign do
                  xml.companyCode(HZ_COMPANY_NO)
                  xml.businessNo(order.order_sn)
                  xml.businessType("IMPORT_ORDER_RETURN")
                  xml.declareType("1")
                  xml.note("")
                end
                xml.goodsReturn do
                  xml.appCode("") #退货申报编号
                  xml.orderNo(order.order_sn)
                  xml.wayBillNo(order.hz_order.way_bills)
                  xml.eCommerceCode(HZ_ECOMMERCE_COMPANY_NO)
                  xml.eCompanyCode(HZ_ECOMMERCE_COMPANY_NAME)
                  xml.internalAreaCompanyNo("") #仓储企业代码
                  xml.declareCompanyCode(HZ_COMPANY_NO)
                  xml.returnWayBillNo("") #退货运单号
                  xml.declareTimeStr(Time.new.strftime("%Y-%m-%d %H:%M:%S"))
                  xml.customsField(order.hz_order.customsField)
                  xml.declPort(order.hz_order.decl_port)
                  xml.packType(order.hz_order.package_type)
                  xml.packNo(order.order_products.collect{|t| t.quantity}.inject{|sum,x| sum + x })
                  xml.mainGName(order.order_products.collect{|t| t.name}.join(","))
                end
                n=1
                xml.goodsReturnDetails do
                  order.order_products.each do |product|
                    xml.goodsReturnDetail do
                      xml.goodsOrder(n)
                      xml.codeTs(product.hz_product.post_tax_no)
                      xml.goodsItemNo(product.product_id)
                      xml.goodsName(product.product.product_description.name)
                      xml.goodsModel(product.product.model)
                      xml.originCountry(product.product.shop.hz_manufacturer.hz_country_code)
                      xml.tradeCurr(order.hz_order.currency_code)
                      xml.tradeTotal(order.total)
                      xml.declarePrice(product.price)
                      xml.declareTotalPrice(product.total)
                      xml.useTo(product.hz_product.hz_purpose_code)
                      xml.declareCount(product.quantity)
                      xml.goodsUnit(product.hz_product.unit_code)
                      xml.goodsGrossWeight(product.product.weight)
                    end
                    n+=1
                  end
                end
              end
            #end
          end
        end
      end
      @output
    end

    # 报文XML模板结束 ===========================================
    def save_result doc
      record_status = doc.at_css("body list jkfResult chkMark").content
      record_comment = doc.at_css("body list jkfResult note").content
      record_time = "#{doc.at_css("body list jkfResult noticeDate").content} #{doc.at_css("body list jkfResult noticeTime").content}".to_datetime
    
      case doc.at_css("body list jkfResult businessType").content.strip
      when "PRODUCT_RECORD"
        HzProduct.where("product_id = ?", doc.at_css("body list jkfResult businessNo").content.strip).update_all(approve_result: response[0], approve_comment: response[1], process_time: response[2] ) if response[0].to_i == 1
      when "IMPORTORDER"
        hz_order = HzOrder.joins(:order).where("oc_order.order_sn = ?", doc.at_css("body list jkfResult businessNo").content.strip)
        hz_order.update_attributes(
          approve_result: record_status, 
          approve_comment: record_comment, 
          process_time: record_time
          )
      when "PERSONAL_GOODS_DECLAR"
        hz_order = HzOrder.joins(:order).where("oc_order.order_sn = ?", doc.at_css("body list jkfResult businessNo").content.strip)
        hz_order.update_attributes(
          pg_result: record_status, 
          pg_comment: record_comment, 
          pg_time: record_time 
          )
      when "IMPORT_ORDER_RETURN"
      end
    end
    def save_personal_good_result doc
      # 查找条件待修改
      order = Order.includes(:hz_order).find_by_order_sn(doc.at_css("body jkfSign businessNo").content.strip)
      order.hz_order.update_attributes(
        personal_goods_form_no: doc.at_css("body jkfGoodsDeclar personalGoodsFormNo").content.strip,
        pg_approve_result: doc.at_css("body jkfGoodsDeclar approveResult").content.strip,
        pg_approve_comment: doc.at_css("body jkfGoodsDeclar approveComment").content.strip,
        pg_approve_time: doc.at_css("body jkfGoodsDeclar processTime").content.strip
        )
    end
    def save_taxineed_result doc
      hz_order = HzOrder.find_by_personal_goods_form_no(doc.at_css("body jkfTaxIsNeedDto personalGoodsFormNo").content.strip)
      hz_order.update_attributes(
        tax_amount: doc.at_css("body jkfTaxIsNeedDto taxAmount").content.strip,
        is_tax_needed: doc.at_css("body jkfTaxIsNeedDto isNeed").content.strip
      )
    end
    def save_importbill_result doc
      way_bill_list = doc.css("billResult")
      way_bill_list.each do |waybillresult|
        way_bill_numbers = waybillresult.at_css("wayBillNos").content.split(",")
        way_bill_numbers.each do |wbn|
          way_bill = HzWayBill.find_by_way_bill_no wbn
          way_bill.update_attributes(
              out_state: waybillresult.at_css("outState").content,
              out_time: waybillresult.at_css("outTime").content
            )
        end
      end
    end
end