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
    @orders = Order.includes(:hz_order).includes(:order_status).order('order_id DESC').paginate page: params[:page], per_page: 20
  end
  def personals
  end
  # 列表清单结束 ==============================

  # 申报接口方法开始 ===================================
  def apply_for_product_record
    @products = Product.includes(:product_description).includes(:hz_product).where("oc_product.product_id in (?)",params[:tick])
    s = render_to_string :file => 'hangzhou/productapplication.xml'
    #filename = "JKF_1SHOO_PRODUCT_RECORD_1_#{@products.first.product_id}_#{Time.new.strftime('%Y%m%d%H%M%S')}"
    #File.open("#{Rails.root}/public/beian/products/#{filename}.xml",'w'){|f| f.write s}
    response = post_to_interface(s, "PRODUCT_RECORD")
    render :json => { :success => true, :html => "OK" },:layout=>false
  end

  def apply_for_order_record
    @orders = Order.includes(:order_products).includes(:hz_order).where("order_id in (?)",params[:tick])
    s = render_to_string :file => 'hangzhou/importorder.xml'
    #filename = "JKF_1SHOO_IMPORTORDER_1_#{@orders.first.order_sn}_#{Time.new.strftime('%Y%m%d%H%M%S')}"
    #File.open("#{Rails.root}/public/beian/orders/#{filename}.xml",'w'){|f| f.write s}
    response = post_to_interface(s, "IMPORTORDER")
    render :json => { :success => true, :html => "OK" },:layout=>false
  end

  def add_importorder_return
    @orders = Order.includes(:order_products).includes(:hz_order).where("order_id in (?)",params[:tick])
    s = render_to_string :file => 'hangzhou/order_return.xml'
    #filename = "JKF_1SHOO_IMPORTORDER_1_#{@orders.first.order_sn}_#{Time.new.strftime('%Y%m%d%H%M%S')}"
    #File.open("#{Rails.root}/public/beian/orders/#{filename}.xml",'w'){|f| f.write s}
    response = post_to_interface(s, "IMPORT_ORDER_RETURN")
    p response.body
    render :json => { :success => true, :html => "OK" },:layout=>false
  end

  def individual_product_apply
    @orderids = params[:order_info][:order_ids].split(",")
    @hz_orders = HzOrder.where("order_id in (?)", @orderids)
    @hz_orders.each do |hz_order|
      hz_order.ie_port = params[:order_info][:ie_port]
      hz_order.customs_field = params[:order_info][:custom_field]
      hz_order.tranf_mode = params[:order_info][:tranf_mode]
      #hz_order.post_mode = params[:order_info][:post_mode]
      hz_order.destination_port = params[:order_info][:destination_port]
      hz_order.decl_port = params[:order_info][:decl_port]
      hz_order.entering_person = params[:order_info][:entering_person]
      hz_order.way_bills = params[:order_info][:way_bills]
      hz_order.sender_city = params[:order_info][:sender_city]
      #hz_order.sender_country = params[:order_info][:sender_country]
      hz_order.save
    end
    @orders = Order.includes(:order_products).includes(:hz_order).where("order_id in (?)",@orderids)
    s = render_to_string :file => 'hangzhou/personal_goods_declare.xml'
    #filename = "JKF_1SHOO_PERSONAL_GOODS_DECLAR_1_#{@orders.first.order_sn}_#{Time.new.strftime('%Y%m%d%H%M%S')}"
    #File.open("#{Rails.root}/public/beian/personals/#{filename}.xml",'w'){|f| f.write s}

    response = post_to_interface(s, "PERSONAL_GOODS_DECLAR")
    #p response.body
    render :json => { :success => true, :html => "OK" },:layout=>false
  end

  def apply_for_company_record
    @company = HzCompany.find params[:id]
    s = render_to_string :file => 'hangzhou/company_applied.xml'
    filename = "JKF_1SHOO_IMPORT_COMPANY_1_#{@company.id}_#{Time.new.strftime('%Y%m%d%H%M%S')}"
    File.open("#{Rails.root}/public/beian/companies/#{filename}.xml",'w'){|f| f.write s}
    response = post_to_interface(s, "IMPORT_COMPANY")
    p response.body
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
    response
  end

  # 添加订单重量与包装方式表单
  def add_order_info
    @packages = HzPackage.all
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
    @hz_order.save
    render :text => "OK", :layout=>false
  end

  # 接受电子口回执处理服务端接口
  def hz_record_result
    # 还原报文
    content = Base64.decode64("v66YKULHFld2JElhm/J9qik2Edr1JHdZIc/k/OesU2GbTX2usXyvF4jGvzvoihrrE8FsfKmllmjsMIjO5fdrS/FD20bYFii4JW3BO3bzshXHyHKLIl2B8y90AfbLu4dnqIh/3IlDZ6aJG58ShqB7ZM0C+n61FVamNzdPjKUGtF5cUHEy1ebMDIe0jFloITh/wGLn6YwujEiYK4Xd5yzI2BpjNSnNqac3gTCf1V9j+oTCBvEQkWiZCA71Gl4wRJsFaNqdjvCnziDF2DfcQEIB+Zqi38j9yZ55ymJY32eDk85nWm4/iCnnjwhY2qCrbrCEZAwJjw8NZSEdORoxKrGnzScR/wdpmgTS+uOhokUW6IGX5ns0ibADs0b8SB+dZY0sghAsfNWBtzW7IPQQoTjjVK7mZok4wPNWvv325k8lOb+e0NiUINnxHaKchDS8EWFwZixkRVV1CDgS/pTa9FXe7mAr1y5TsRrlmA9/kF/82J15rKqqw53TKvTYe1SIlbrlxDPQ3yN8ksCN+2k7Y+o8KWBPVIi1xlG1n/ssdDftuSauHeEqoOhNuO1i6uuehVhEQ8bxJ6XUL78rAkHvmP1iCSTX3u2cBvhnWWIfB4AJykAoYE1tSo/T1W3avyUYw8bEhl5wDrnUzioo0hNcOEMOeQybAowilX6KZ9PNnVmnbME0b8tXrzrE0i0iCi8kLy0oMm8gl5KwhnNP8gT+YhGyUkdxBwS9aUMgEAFlZ2CAKeYj4EnlAn25aVTwh0xyIISMHt+37JVRIlIy4DoJk7lQzwWZQR68365GKdvomZHwqgUOiMcHFyqU5bfsGbgytwT3t4YjIOWjBAafQUNFAJhOzj9w4NSPrU7gZQcklxDxBLT5ZE+SOilhDZjlGi+D2LzaepBzyVZZ793LNioWSNWtcvc1OHtW6Dr4gtzOqKogAGi3/0zIyPzFQ4uXyNx2p3nOOVf/3fgtS44UFZiStiS4w/hMaCV4giRB7ovYMZ6I962Yy3MsAiLnViGsNPy4n5Mf2G0kFyQg8fe3je1CzdUELTBAEU5ZjWbRvxcpPdVrOz7stRqyxM/DBsVPiTf3o5jKk4e/kFu2DblOm3h3VhMOwlGHagt4oddsxHVb6xKAh2M=")
    key = Base64.decode64(AES_PRIVATE_KEY)
    decrypted_data = AESCrypt.decrypt_data(content, key, nil, "AES-128-ECB")

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
    
    #xml = "<?xml version=\"1.0\" encoding=\"UTF-8\" ?><mo version=\"1.0.0\"><head><businessType>RESULT</businessType></head><body><list><jkfResult><companyCode>1234567890</companyCode><businessNo>107</businessNo><businessType>PRODUCT_RECORD</businessType><declareType>1</declareType><chkMark>1</chkMark><noticeDate>2014-10-24</noticeDate><noticeTime>09:02</noticeTime><note>备注</note><resultList><jkfResultDetail><resultInfo>处理成功</resultInfo></jkfResultDetail></resultList></jkfResult></list></body></mo>"
    #xml = "<?xml version=\"1.0\" encoding=\"UTF-8\" ?><mo version=\"1.0.0\"><head><businessType>RESULT</businessType></head><body><list><jkfResult><companyCode>1234567890</companyCode><businessNo>6751406356998</businessNo><businessType>IMPORTORDER</businessType><declareType>1</declareType><chkMark>1</chkMark><noticeDate>2014-10-24</noticeDate><noticeTime>09:51</noticeTime><resultList><jkfResultDetail><resultInfo>处理成功</resultInfo></jkfResultDetail></resultList></jkfResult></list></body></mo>" #order
    #xml = "<?xml version=\"1.0\" encoding=\"UTF-8\" ?><mo version=\"1.0.0\"><head><businessType>RESULT</businessType></head><body><list><jkfResult><companyCode>1234567890</companyCode><businessNo>6751406356998</businessNo><businessType>PERSONAL_GOODS_DECLAR</businessType><declareType>1</declareType><chkMark>1</chkMark><noticeDate>2014-10-24</noticeDate><noticeTime>08:13</noticeTime><resultList><jkfResultDetail><resultInfo>处理成功</resultInfo></jkfResultDetail></resultList></jkfResult><jkfResult><companyCode>1234567890</companyCode><businessNo>7741406357058</businessNo><businessType>PERSONAL_GOODS_DECLAR</businessType><declareType>1</declareType><chkMark>1</chkMark><noticeDate>2014-10-24</noticeDate><noticeTime>08:13</noticeTime><resultList><jkfResultDetail><resultInfo>处理成功</resultInfo></jkfResultDetail></resultList></jkfResult></list></body></mo>"
    render :text => decrypted_data, :layout=>false
    
  end
  
end