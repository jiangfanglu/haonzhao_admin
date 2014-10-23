class HangzhouController < ApplicationController
  skip_before_filter  :verify_authenticity_token
  def importorder
    #@orders = Order.includes(:order_products).includes(:hz_order).where("order_id in (?)",params[:oids].split(","))
  end
  def company_applied
    #@companies = HzCompany.where("id in (?)",params[:cids].split(","))
  end
  def personal_goods_declare
  	 #@orders = Order.includes(:order_products).includes(:hz_order).where("order_id in (?)",params[:oids])
  end
  def taxisneed
  end
  def productapplication
    #@products = Product.includes(:shop).includes(:product_description).includes(:hz_product).where("product_id in (109,107)")
  end

  def products
    @products = Product.includes(:product_description).includes(:hz_product).order('product_id DESC').paginate page: params[:page], per_page: 20
  end
  def orders
    @orders = Order.includes(:hz_order).includes(:order_status).order('order_id DESC').paginate page: params[:page], per_page: 20
  end
  def personals
  end

  def apply_for_product_record
    @products = Product.includes(:product_description).includes(:hz_product).where("oc_product.product_id in (?)",params[:tick])
    s = render_to_string :file => 'hangzhou/productapplication.xml'
    filename = "JKF_1SHOO_PRODUCT_RECORD_1_#{@products.first.product_id}_#{Time.new.strftime('%Y%m%d%H%M%S')}"
    File.open("#{Rails.root}/public/beian/products/#{filename}.xml",'w'){|f| f.write s}
    response = post_to_interface(s, "PRODUCT_RECORD")
    p response
    render :json => { :success => true, :html => "OK" },:layout=>false
  end

  def apply_for_order_record
    @orders = Order.includes(:order_products).includes(:hz_order).where("order_id in (?)",params[:tick])
    s = render_to_string :file => 'hangzhou/importorder.xml'
    filename = "JKF_1SHOO_IMPORTORDER_1_#{@orders.first.order_sn}_#{Time.new.strftime('%Y%m%d%H%M%S')}"
    File.open("#{Rails.root}/public/beian/orders/#{filename}.xml",'w'){|f| f.write s}

    render :json => { :success => true, :html => "OK" },:layout=>false
  end

  def individual_product_apply
    @orderids = params[:order_info][:order_ids].split(",")
    @hz_orders = HzOrder.where("order_id in (?)", @orderids)
    @hz_orders.each do |hz_order|
      hz_order.ie_port = params[:order_info][:ie_port]
      hz_order.customs_field = params[:order_info][:custom_field]
      hz_order.tranf_mode = params[:order_info][:tranf_mode]
      hz_order.post_mode = params[:order_info][:post_mode]
      hz_order.destination_port = params[:order_info][:destination_port]
      hz_order.decl_port = params[:order_info][:decl_port]
      hz_order.entering_person = params[:order_info][:entering_person]
      hz_order.way_bills = params[:order_info][:way_bills]
      hz_order.sender_city = params[:order_info][:sender_city]
      hz_order.sender_country = params[:order_info][:sender_country]
      hz_order.save
    end
    @orders = Order.includes(:order_products).includes(:hz_order).where("order_id in (?)",@orderids)
    s = render_to_string :file => 'hangzhou/personal_goods_declare.xml'
    filename = "JKF_1SHOO_PERSONAL_GOODS_DECLAR_1_#{@orders.first.order_sn}_#{Time.new.strftime('%Y%m%d%H%M%S')}"
    File.open("#{Rails.root}/public/beian/personals/#{filename}.xml",'w'){|f| f.write s}

    response = post_to_interface(s, "PERSONAL_GOODS_DECLAR")

    render :json => { :success => true, :html => "OK" },:layout=>false
  end

  def apply_for_company_record
    @company = HzCompany.find params[:id]
    s = render_to_string :file => 'hangzhou/company_applied.xml'
    filename = "JKF_1SHOO_IMPORT_COMPANY_1_#{@company.id}_#{Time.new.strftime('%Y%m%d%H%M%S')}"
    File.open("#{Rails.root}/public/beian/companies/#{filename}.xml",'w'){|f| f.write s}
    render :json => { :success => true, :html => "OK" },:layout=>false
  end

  def add_importorder_return
  end

  def post_to_interface content, business_type

    client = Savon.client(wsdl: HZ_RECORD_URL)
    begin
      response = client.call(:check_received, :message=> {:arg0 => content, :arg1 => business_type, :arg2 => '1'})
    rescue Savon::Error => soap_fault
      print soap_fault.http.body
    end
    response
  end


  def add_order_info
    @packages = HzPackage.all
    render :layout=>false
  end

  def apply_personal_goods_form
    @transports = HzTransport.all
    #@domestic_ports = HzDomesticPorts.all.order("name asc")
    #@ports = HzPort.all.order("name asc")
    @post_modes = HzLogisticMode.all.order("name asc")
    @countries = HzCountry.all.order("name asc")
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

  def hz_record_result
    #taxi_need
    #personal_good_declr_result
    #product_record_result
    content = params[:content]
    

    text = "bad"
    if Base64.encode64(Digest::MD5.digest(content+key)).strip == params[:data_digest]
      text = "OK"
    end
    render :text => text, :layout=>false
  end

#"content"=>"v66YKULHFld2JElhm/J9qik2Edr1JHdZIc/k/OesU2GbTX2usXyvF4jGvzvoihrrE8FsfKmllmjsMIjO5fdrS/FD20bYFii4JW3BO3bzshXHyHKLIl2B8y90AfbLu4dnqIh/3IlDZ6aJG58ShqB7ZM0C+n61FVamNzdPjKUGtF5cUHEy1ebMDIe0jFloITh/wGLn6YwujEiYK4Xd5yzI2BpjNSnNqac3gTCf1V9j+oTCBvEQkWiZCA71Gl4wRJsFaNqdjvCnziDF2DfcQEIB+Zqi38j9yZ55ymJY32eDk85nWm4/iCnnjwhY2qCrbrCEZAwJjw8NZSEdORoxKrGnzScR/wdpmgTS+uOhokUW6IGX5ns0ibADs0b8SB+dZY0sghAsfNWBtzW7IPQQoTjjVK7mZok4wPNWvv325k8lOb+e0NiUINnxHaKchDS8EWFwZixkRVV1CDgS/pTa9FXe7mAr1y5TsRrlmA9/kF/82J15rKqqw53TKvTYe1SIlbrlxDPQ3yN8ksCN+2k7Y+o8KWBPVIi1xlG1n/ssdDftuSauHeEqoOhNuO1i6uuehVhEQ8bxJ6XUL78rAkHvmP1iCSTX3u2cBvhnWWIfB4AJykAoYE1tSo/T1W3avyUYw8bEhl5wDrnUzioo0hNcOEMOeQybAowilX6KZ9PNnVmnbME0b8tXrzrE0i0iCi8kLy0oMm8gl5KwhnNP8gT+YhGyUkdxBwS9aUMgEAFlZ2CAKeYj4EnlAn25aVTwh0xyIISMHt+37JVRIlIy4DoJk7lQzwWZQR68365GKdvomZHwqgUOiMcHFyqU5bfsGbgytwT3t4YjIOWjBAafQUNFAJhOzj9w4NSPrU7gZQcklxDxBLT5ZE+SOilhDZjlGi+D2LzaepBzyVZZ793LNioWSNWtcvc1OHtW6Dr4gtzOqKogAGi3/0zIyPzFQ4uXyNx2p3nOOVf/3fgtS44UFZiStiS4w/hMaCV4giRB7ovYMZ6I962Yy3MsAiLnViGsNPy4n5Mf2G0kFyQg8fe3je1CzdUELTBAEU5ZjWbRvxcpPdVrOz7stRqyxM/DBsVPiTf3o5jKk4e/kFu2DblOm3h3VhMOwlGHagt4oddsxHVb6xKAh2M=", "msg_type"=>"CUSTOMS_DECLARE_RESULT_CALLBACK", "data_digest"=>"jpLVxJ60FQqG+b6/6DdptbtAFKduAr2RoqMIOS1SK14GNSjYsjv+xMHYZOJ6dDLVvCcYUHMZdyjgwT94jPjCwObxBJp0fAmGWksYXAaMl4gD0cdjQSIwkFUbzxMqfsHJ6FTigre4MY45mgWVWL2HIT9LR5Y0fPQBNKuyj1Xm8SE="
#pubkey: 

  # def record_importorder_result
  # end
  # def record_productrecord_result
  # end
  # def record_personal_goods_result
  # end
  # def record_importcompany_result
  # end
  # def record_is_taxineed_result
  # end
  # def record_return_order_result
  # end

  def ws_test
    content = Base64.decode64("v66YKULHFld2JElhm/J9qik2Edr1JHdZIc/k/OesU2GbTX2usXyvF4jGvzvoihrrE8FsfKmllmjsMIjO5fdrS/FD20bYFii4JW3BO3bzshXHyHKLIl2B8y90AfbLu4dnqIh/3IlDZ6aJG58ShqB7ZM0C+n61FVamNzdPjKUGtF5cUHEy1ebMDIe0jFloITh/wGLn6YwujEiYK4Xd5yzI2BpjNSnNqac3gTCf1V9j+oTCBvEQkWiZCA71Gl4wRJsFaNqdjvCnziDF2DfcQEIB+Zqi38j9yZ55ymJY32eDk85nWm4/iCnnjwhY2qCrbrCEZAwJjw8NZSEdORoxKrGnzScR/wdpmgTS+uOhokUW6IGX5ns0ibADs0b8SB+dZY0sghAsfNWBtzW7IPQQoTjjVK7mZok4wPNWvv325k8lOb+e0NiUINnxHaKchDS8EWFwZixkRVV1CDgS/pTa9FXe7mAr1y5TsRrlmA9/kF/82J15rKqqw53TKvTYe1SIlbrlxDPQ3yN8ksCN+2k7Y+o8KWBPVIi1xlG1n/ssdDftuSauHeEqoOhNuO1i6uuehVhEQ8bxJ6XUL78rAkHvmP1iCSTX3u2cBvhnWWIfB4AJykAoYE1tSo/T1W3avyUYw8bEhl5wDrnUzioo0hNcOEMOeQybAowilX6KZ9PNnVmnbME0b8tXrzrE0i0iCi8kLy0oMm8gl5KwhnNP8gT+YhGyUkdxBwS9aUMgEAFlZ2CAKeYj4EnlAn25aVTwh0xyIISMHt+37JVRIlIy4DoJk7lQzwWZQR68365GKdvomZHwqgUOiMcHFyqU5bfsGbgytwT3t4YjIOWjBAafQUNFAJhOzj9w4NSPrU7gZQcklxDxBLT5ZE+SOilhDZjlGi+D2LzaepBzyVZZ793LNioWSNWtcvc1OHtW6Dr4gtzOqKogAGi3/0zIyPzFQ4uXyNx2p3nOOVf/3fgtS44UFZiStiS4w/hMaCV4giRB7ovYMZ6I962Yy3MsAiLnViGsNPy4n5Mf2G0kFyQg8fe3je1CzdUELTBAEU5ZjWbRvxcpPdVrOz7stRqyxM/DBsVPiTf3o5jKk4e/kFu2DblOm3h3VhMOwlGHagt4oddsxHVb6xKAh2M=")
    key = Base64.decode64("qZe60QZFxuirub2ey4+7+Q==")
    decrypted_data = AESCrypt.decrypt_data(content, key, nil, "AES-128-ECB")
    key = "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCffOeIVYut9jW5w1L5uKX4aDvd837a8JhaWm5S8YqNQfgEmfD9T+rDknXLqMT+DXeQAqGo4hBmcbej1aoMzn6hIJHk3/TfTAToNN8fgwDotHewsTCBbVkQWtDTby3GouWToVsRi1i/A0Vfb0+xM8MnF46DdhhrnZrycERBSbyrcwIDAQAB"
    input_data = content.force_encoding("utf-8")
    public_key = Base64.decode64(key)
    rsa_public_key = OpenSSL::PKey::RSA.new(public_key,decrypted_data)
    text = rsa_public_key.public_decrypt(input_data)
    
    #text = Base64.encode64(Digest::MD5.hexdigest(decrypted_data+"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCffOeIVYut9jW5w1L5uKX4aDvd837a8JhaWm5S8YqNQfgEmfD9T+rDknXLqMT+DXeQAqGo4hBmcbej1aoMzn6hIJHk3/TfTAToNN8fgwDotHewsTCBbVkQWtDTby3GouWToVsRi1i/A0Vfb0+xM8MnF46DdhhrnZrycERBSbyrcwIDAQAB")).strip

    render :text => text, :layout=>false
    
  end
  
end