class HangzhouController < ApplicationController
  def importorder
    @temp = {:bar=>"1",:foo=>{:du=>2,:goo=>"asdsad"}}
  end
  def company_applied
    @companies = HzCompany.where("id in (?)",params[:cids].split(","))
  end
  def personal_goods_declare
  	
  end
  def taxisneed
  end
  def productapplication
    @products = Product.includes(:shop).includes(:product_description).includes(:hz_product).where("product_id in (?)", params[:pids].split(","))
  end

  def products
    @products = Product.includes(:product_description).includes(:hz_product).order('product_id DESC').paginate page: params[:page], per_page: 20
  end
  def orders
    #@orders = Product.includes(:product_description).includes(:hz_product).order('product_id DESC').paginate page: params[:page], per_page: 20
  end
  def personals
  end
  def individual_product_apply
  end

  def apply_for_product_record
    product_ids = params[:ids].collect{|key,value| value["value"]}.map{|t|t.to_i}
    http = Net::HTTP.new("localhost",3000)
    response = http.post("/hangzhou/ws_test", "haha")
    render :text=>response.body, :layout=>false
  end

  def ws_test
      render :text=>"OKLA", :layout=>false
  end

  def company
  end
  
end
