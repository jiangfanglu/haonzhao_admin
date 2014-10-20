class HangzhouController < ApplicationController
  skip_before_filter  :verify_authenticity_token, :except=>[:hz_record_result]
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
    # uri = URI(HZ_RECORD_URL)
    # p HZ_RECORD_URL
    # request = Net::HTTP::Post.new uri.request_uri
    # request["Content-type"] = "application/x-www-form-urlencoded;charset:GBK,UTF-8"
    # request.set_form_data(
    #     'arg0' => content,
    #     'arg1' => business_type,
    #     'arg2' => "1"
    #   )
    # response = Net::HTTP.start(uri.hostname, uri.port) do |http|
    #   http.request(request)
    # end
    # response

    client = Savon.client(wsdl: HZ_RECORD_URL)
    begin
      response = client.call(:check_received, :message=> {:arg0 => content, :arg1 => business_type, :arg2 => '1'})
    rescue Savon::Error => soap_fault
      print "Error: #{soap_fault}\n"
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
    
  end

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
    @orders = Order.includes(:order_products).includes(:hz_order).where("order_id in (119)")
    s = render_to_string :file => 'hangzhou/importorder.xml'
    filename = "JKF_1SHOO_IMPORTORDER_1_#{@orders.first.order_sn}_#{Time.new.strftime('%Y%m%d%H%M%S')}"
    File.open("#{Rails.root}/public/beian/orders/#{filename}.xml",'w'){|f| f.write s}
    render :text => s
    #render :text=>"DONE", :layout=>false
  end
  
end
