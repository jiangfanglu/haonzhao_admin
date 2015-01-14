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
    @products = Product.includes(:product_description).includes(:hz_product).where("hz_products.approve_result <> '1' or hz_products.approve_result is null").order('oc_product.product_id DESC').paginate page: params[:page], per_page: 20
  end
  def orders
    @orders = Order.includes(:hz_order).includes(:order_status).where("hz_orders.approve_result <> '1' or hz_orders.approve_result is null").references(:hz_order).order('oc_order.order_id DESC').paginate page: params[:page], per_page: 20
  end
  def personals
    @orders = Order.includes(:hz_order).includes(:hz_way_bills).where("hz_way_bills.out_state <> '1' or  hz_way_bills.out_state is null").order('oc_order.order_id DESC').references(:hz_order).paginate page: params[:page], per_page: 20
  end
  def order_returns
    @orders = Order.includes(:hz_order).includes(:hz_way_bills).order('oc_order.order_id DESC').references(:hz_order).paginate page: params[:page], per_page: 20
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

  def product_shelfing
    @products = Product.where("oc_product.product_id in (?)",params[:tick])
    @products.each do |product|
      product.update_attributes(
        status: 1 
      )
    end
    render :text=>"OK",:layout=>false
  end

  def apply_for_order_record
    @orderids = params[:order_info][:order_ids].split(",")
    @orders = Order.includes(:order_products).includes(:hz_order).where("order_id in (?)",@orderids)
    @orders.each do |order|
      order.hz_order.update_attributes(
        :sender_name=> params[:order_info][:sender_name], 
        :sender_country=> params[:order_info][:sender_country], 
        :post_mode=> params[:order_info][:tranf_mode]
      )

      response = post_to_interface(order_xml(order), "IMPORTORDER")
      if response[0].to_i == 1
        order.hz_order.update_attributes(
          approve_result: response[0], 
          approve_comment: response[1], 
          process_time: response[2] 
        ) 

        order.order_status = OrderStatus.where(name: 'Import order Pending').first and save
      end
    end
    render :text=>"OK",:layout=>false
  end

  def add_importorder_return
    @return_orders = HzOrderReturn.includes(:order).where("id in (?)",params[:tick])
    @return_orders.each do |hz_order_return|
      produc_array = JSON.parse(hz_order_return.return_product_ids)
      products = OrderProduct.where("order_product_id in (?)",produc_array.collect{|k,v| k['id'].to_i})

      order_return_products = []
      produc_array.each do |pa|
        order_return_products.append({
            :product=> products.where("order_product_id = ?", pa['id']).first,
            :quantity=>pa['quantity']
          })
      end

      response = post_to_interface(order_return_xml(hz_order_return, order_return_products), "IMPORT_ORDER_RETURN")

      hz_order_return.update_attributes(
        approve_result: response[0], 
        approve_comment: response[1], 
        approve_time: response[2] 
      ) if response[0].to_i == 1
    end
    render :text=>"OK",:layout=>false
  end

  def individual_product_apply
    @orderids = params[:order_info][:order_ids].split(",")
    @way_bills = HzWayBill.includes(:order).where("hz_way_bills.order_id in (?)",@orderids)

    @way_bills.each do |way_bill|
     way_bill.update_attributes(
          ie_port: params[:order_info][:ie_port],
          custom_field: params[:order_info][:custom_field],
          tranf_mode: params[:order_info][:tranf_mode],
          destination_port: params[:order_info][:destination_port],
          decl_port: params[:order_info][:decl_port],
          entering_person: params[:order_info][:entering_person],
          sender_city: params[:order_info][:sender_city],
          logistic_company_code: "3301980093", 
          logistic_company_name: "浙江顺丰速运有限公司", 
          post_mode: "1", 
          sender_country: "601", 
          sender_name: "上海一树网络科技有限公司(澳洲)", 
          personal_goods_form_no: "", 
          tax_amount: 0,
          is_tax_needed: ""
        )
      
      response = post_to_interface(personal_goods_xml(way_bill), "PERSONAL_GOODS_DECLAR")
      
      way_bill.update_attributes(
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
    p response.body
    doc = Nokogiri::XML(response.body[:check_received_response][:return])
    record_status = doc.at_css("body list jkfResult chkMark").content
    #record_comment = doc.at_css("body list jkfResult note").content
    record_time = "#{doc.at_css("body list jkfResult noticeDate").content} #{doc.at_css("body list jkfResult noticeTime").content}".to_datetime
    return [record_status,"",record_time]
  end

  # 添加订单重量与包装方式表单
  def add_order_info
    @packages = HzPackage.all
    @way_bill = HzWayBill.find params[:wbid]
    @order_products = @way_bill.order.order_products
    @order_products = @order_products.where("order_product_id not in (#{@way_bill.order_product_ids})") unless @way_bill.order_product_ids.blank?
    render :layout=>false
  end

  def add_order_sender
    @countries = HzCountry.all.order("name asc")
    @post_modes = HzLogisticMode.all
    @sender_names = ['一树网络科技有限公司（澳洲）']
    render :layout=>false
  end

  def view_way_bill
    @way_bill = HzWayBill.find params[:wbid]
    @order_products = @way_bill.order.order_products
    @order_products = @order_products.where("order_product_id in (#{@way_bill.order_product_ids})") unless @way_bill.order_product_ids.blank?
    render :layout=>false
  end

  # 退单表
  def new_order_return
    order_return = HzOrderReturn.new
    order_return.order_id = params[:id]
    order_return.save
    redirect_to request.referer+"#or#{order_return.id}"
  end

  def remove_order_return
    HzOrderReturn.delete params[:id]
    redirect_to request.referer
  end

  def add_order_return_form
    @packages = HzPackage.all
    @order_return = HzOrderReturn.includes(:order).find params[:order_return_id]

    render :layout=>false
  end

  def save_order_return
    @order_return = HzOrderReturn.find params[:order_return_id]
    return_product_ids = []
    params[:return_quantity].each do |x, y|
      select = y['value'].split("_")
      return_product_ids.append({:id=>select[0],:quantity=>select[1]}) if select[1].to_i > 0
    end

    @order_return.update_attributes(
          app_code: "1SHOOOR#{@order_return.id}",
          customs_field: params[:custom_field],
          decl_port: params[:decl_port],
          return_way_bill_no: params[:return_way_bill_no],
          original_way_bill_no: params[:original_way_bill_no],
          pack_no: return_product_ids.collect{|t| t[:quantity].to_i}.inject{|sum,x| sum + x },
          pack_type: params[:pack_type],
          return_product_ids: return_product_ids.to_json,
          decl_time: Time.new.strftime("%Y-%m-%d %H:%M:%S")
      )
    @order_return.save
    render :text => "OK", :layout=>false
  end

  # 个人物品申报附加信息表单
  def apply_personal_goods_form
    @transports = HzTransport.all
    render :layout=>false
  end

  def add_way_bill
    way_bill = HzWayBill.new
    way_bill.order_id = params[:id]
    way_bill.save
    redirect_to request.referer+"#wb#{way_bill.id}"
  end

  def remove_way_bill
    HzWayBill.delete params[:id]
    redirect_to request.referer
  end


  def save_order_extra_info
    @way_bill = HzWayBill.find params[:way_bill_id]
    @way_bill = HzWayBill.new if @way_bill.blank?
    @way_bill.order_id = params[:orderid] if @way_bill.order_id.blank?
    @way_bill.package_type = params[:package_type]
    @way_bill.gross_weight = params[:gross_weight]
    @way_bill.way_bill_no = params[:way_bill_no]
    @way_bill.order_product_ids = params[:order_product_ids].collect{|key,value| value[:value]}.join(",")
    @way_bill.save

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
                  xml.businessNo(product.product_id)
                  xml.businessType("PRODUCT_RECORD")
                  xml.declareType("1")
                  xml.note("")
                end
                xml.productRecordDto do
                  xml.companyCode(HZ_COMPANY_NO) #电商平台备案取得的唯一标示
                  xml.companyName(HZ_COMPANY_NAME)
                  xml.postTaxNo(product.hz_product.post_tax_no) #海关10位行邮税号, 见参数表
                  xml.goodsType(product.hz_product.hz_post_tax.item_category)
                  xml.goodsName(product.product_description.name)
                  xml.barCode(product.hz_product.barcode) #optional
                  xml.brand(product.shop.name) #optional
                  xml.goodsModel(product.model) #optional
                  xml.mainElement(product.hz_product.main_elements) #optional
                  xml.purpose(product.hz_product.hz_purpose_code) #optional
                  xml.standards(product.hz_product.standard) #optional
                  xml.productionEnterprise(product.shop.name) #optional
                  xml.productionCountry(product.shop.hz_manufacturer.hz_country.code) #optional
                  xml.licenceKey("") #optional
                  xml.categoryCode("1234567890") #optional
                  xml.materialAddress(product.hz_product.material_address) #指国检要求提交的产品备案材料，此处指材料的片地址, optional
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
                  xml.eCommerceCode(order.hz_order.hz_company.company_code)
                  xml.eCommerceName(order.hz_order.hz_company.company_name)
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
                  xml.logisCompanyName("浙江顺丰速运有限公司")
                  xml.logisCompanyCode("3301980093")
                  xml.zipCode(order.shipping_postcode) #optional
                  xml.note("") #optional
                  xml.wayBills(order.hz_way_bills.collect{|wb| wb.way_bill_no}.join(",")) #optional
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
                      xml.originCountry(order_product.hz_product.sender_country_code) #见参数表
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
                  xml.paperType(order.customer.user.blank? ? "" : "0"+order.address.customer_identification.identification_type.to_s) 
                            xml.paperNumber(order.customer.user.blank? ? "" : order.address.customer_identification.identification_no)
                end
              end
            #end
          end
        end  
      end
      @output
    end
    def personal_goods_xml way_bill
      order = way_bill.order
      hz_order = way_bill.hz_order
      order_products = OrderProduct.includes(:product).where("order_product_id in (?)",way_bill.order_product_ids.split(","))
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
                  xml.businessNo(way_bill.way_bill_no)
                  xml.businessType("PERSONAL_GOODS_DECLAR")
                  xml.declareType("1")
                  xml.note("") #can be null
                end
                xml.goodsDeclare do
                  xml.accountBookNo("") #optional
                  xml.ieFlag("I")
                  xml.preEntryNumber("SHYS#{Time.new.strftime("%Y%m%d%H%M%S")}")
                  xml.importType("0") #0：一般进口, 1：保税进口
                  xml.inOutDateStr("") #格式：2014-02-18 20:33:33
                  xml.iePort(way_bill.ie_port) #见参数表
                  xml.destinationPort(way_bill.destination_port) #见参数表
                  xml.trafName("") # 运输工具名称 :包括字母和数字.可以填写中文.转关时填写@+16位转关单号. optional
                  xml.voyageNo("") # 运输工具航次(班)号 : 新增，包括字母和数字，可以有中文. optional
                  xml.trafMode(way_bill.tranf_mode) #参照运输方式代码表(TRANSF)
                  xml.declareCompanyType("个人委托电商企业申报") #个人委托电商企业申报;个人委托物流企业申报;个人委托第三方申报
                  xml.declareCompanyCode(HZ_COMPANY_NO) #指委托申报单位代码
                  xml.declareCompanyName(HZ_COMPANY_NAME) #指委托申报单位名称
                  xml.eCommerceCode(order.hz_order.hz_company.company_code) 
                  xml.eCommerceName(order.hz_order.hz_company.company_name)
                  xml.orderNo(order.order_sn)
                  xml.wayBill(way_bill.way_bill_no)
                  xml.tradeCountry(order.shop.hz_manufacturer.hz_country_code) #参照国别代码表(COUNTRY)
                  xml.packNo(order_products.sum("oc_order_product.quantity")) #只能有数字
                  xml.grossWeight(way_bill.gross_weight) 
                  xml.netWeight("") #optional
                  xml.warpType(way_bill.package_type) #参照包装种类代码表
                  xml.remark("") #optional
                  xml.declPort(way_bill.decl_port) #对应参数表
                  xml.enteringPerson(way_bill.entering_person) #默认9999
                  xml.enteringCompanyName(HZ_COMPANY_NAME) #默认9999
                  xml.declarantNo("") #optional
                  xml.customsField(way_bill.custom_field) #对应参数表
                  xml.senderName(way_bill.sender_name)
                  xml.consignee(order.firstname)
                  xml.senderCountry(way_bill.sender_country) #参数表
                  xml.senderCity(way_bill.sender_city)
                  xml.paperType(order.address.customer_identification.identification_type.to_s) #身份证（试点时期）
                  xml.paperNumber(order.address.customer_identification.identification_no)
                  #xml.paperType("") #身份证（试点时期）
                  #xml.paperNumber("")
                  xml.worth(order.total) #只有数字，表体所有商品成交总价的和
                  xml.currCode(hz_order.currency_code)  #对应参数表
                  xml.mainGName(order_products.collect{|t| t.name}.join(","))  #可以数字和字母或者中文
                  xml.internalAreaCompanyNo("") #optional
                  xml.internalAreaCompanyName("") #optional
                  xml.applicationFormNo("") #optional
                  xml.isAuthorize("1")
                end
                xml.goodsDeclareDetails do
                  order_products.each do |product|
                    xml.goodsDeclareDetail do
                      xml.goodsOrder(product.product_id)
                      xml.codeTs(product.product.hz_product.post_tax_no)
                      xml.goodsItemNo(product.product_id)
                      xml.goodsName(product.name)
                      xml.goodsModel(product.model)
                      xml.originCountry(product.hz_product.sender_country_code) #参照国别代码表(COUNTRY)
                      xml.tradeCurr(hz_order.currency_code) #参照币制代码表(CURR)
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
    def order_return_xml hz_order_return, hz_order_return_products
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
                  xml.businessNo(hz_order_return.app_code)
                  xml.businessType("IMPORT_ORDER_RETURN")
                  xml.declareType("1")
                  xml.note("")
                end
                xml.goodsReturn do
                  xml.appCode(hz_order_return.app_code) #退货申报编号
                  xml.orderNo(hz_order_return.order.order_sn)
                  xml.wayBillNo(hz_order_return.original_way_bill_no)
                  xml.eCommerceCode(order.hz_order.hz_company.company_code)
                  xml.eCompanyCode(order.hz_order.hz_company.company_name)
                  xml.internalAreaCompanyNo("") #仓储企业代码
                  xml.declareCompanyCode(HZ_COMPANY_NO)
                  xml.returnWayBillNo(hz_order_return.return_way_bill_no) #退货运单号
                  xml.declareTimeStr(hz_order_return.decl_time)
                  xml.customsField(hz_order_return.customs_field)
                  xml.declPort(hz_order_return.decl_port)
                  xml.packType(hz_order_return.pack_type)
                  xml.packNo(hz_order_return.pack_no)
                  xml.mainGName(hz_order_return_products.collect{|t| t[:product].name}.join(","))
                end
                n=1
                xml.goodsReturnDetails do
                  hz_order_return_products.each do |product|
                    xml.goodsReturnDetail do
                      xml.goodsOrder(n)
                      xml.codeTs(product[:product].hz_product.post_tax_no)
                      xml.goodsItemNo("")
                      xml.goodsName(product[:product].product.product_description.name)
                      xml.goodsModel(product[:product].model)
                      xml.originCountry(product[:product].hz_product.sender_country_code)
                      xml.tradeCurr(hz_order_return.order.hz_order.currency_code)
                      xml.tradeTotal(product[:product].total)
                      xml.declarePrice(product[:product].price)
                      xml.declareTotalPrice( product[:product].price * product[:quantity].to_f )
                      xml.declareCount(product[:quantity])
                      xml.useTo(product[:product].hz_product.hz_purpose_code)
                      xml.goodsUnit(product[:product].hz_product.unit_code)
                      xml.goodsGrossWeight(product[:product].product.weight)
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
        hz_order = HzOrder.joins(:order).where("oc_order.order_sn = ?", doc.at_css("body list jkfResult businessNo").content.strip).first
        hz_order.update_attributes(
          approve_result: record_status, 
          approve_comment: record_comment, 
          process_time: record_time
          )
        hz_order.order.order_status = OrderStatus.where(name: 'Import Order Approved').first and save
      when "PERSONAL_GOODS_DECLAR"
        way_bill = HzWayBill.find_by_way_bill_no(doc.at_css("body list jkfResult businessNo").content.strip)
        way_bill.update_attributes(
          pg_result: record_status, 
          pg_comment: record_comment, 
          pg_time: record_time 
          )
      when "IMPORT_ORDER_RETURN"
        hz_order = HzOrderReturn.find_by_app_code(doc.at_css("body list jkfResult businessNo").content.strip)
        hz_order.update_attributes(
          approve_result: record_status, 
          approve_comment: record_comment, 
          approve_time: record_time
          )
      end
    end
    def save_personal_good_result doc
      way_bill = HzWayBill.find_by_way_bill_no(doc.at_css("body jkfSign businessNo").content.strip)
      order.hz_order.update_attributes(
        personal_goods_form_no: doc.at_css("body jkfGoodsDeclar personalGoodsFormNo").content.strip,
        pg_approve_result: doc.at_css("body jkfGoodsDeclar approveResult").content.strip,
        pg_approve_comment: doc.at_css("body jkfGoodsDeclar approveComment").content.strip,
        pg_approve_time: doc.at_css("body jkfGoodsDeclar processTime").content.strip
        )
    end
    def save_taxineed_result doc
      way_bill = HzWayBill.find_by_way_bill_no(doc.at_css("body jkfSign businessNo").content.strip)
      way_bill.update_attributes(
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