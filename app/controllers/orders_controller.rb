class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy, :cancel]

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.order('order_id DESC').paginate page: params[:page], per_page: 20
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # # GET /orders/new
  # def new
  #   @order = Order.new
  # end

  # GET /orders/1/edit
  def edit
  end

  def cancel
    respond_to do |format|
      if @order.cancel
        format.html { redirect_to @order, notice: 'Order was successfully canceled.' }
        format.json { head :no_content }
      else
        format.html { render action: 'show' }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def restore
    respond_to do |format|
      if @order.restore
        format.html { redirect_to @order, notice: 'Order was successfully restored.' }
        format.json { head :no_content }
      else
        format.html { render action: 'show' }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # # POST /orders
  # # POST /orders.json
  # def create
  #   @order = Order.new(order_params)
  # 
  #   respond_to do |format|
  #     if @order.save
  #       format.html { redirect_to @order, notice: 'Order was successfully created.' }
  #       format.json { render action: 'show', status: :created, location: @order }
  #     else
  #       format.html { render action: 'new' }
  #       format.json { render json: @order.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:invoice_no, :invoice_prefix, :store_id, :store_name, :store_url, :customer_id, :customer_group_id, :firstname, :lastname, :email, :telephone, :fax, :payment_firstname, :payment_lastname, :payment_company, :payment_company_id, :payment_tax_id, :payment_address_1, :payment_address_2, :payment_city, :payment_postcode, :payment_country, :payment_country_id, :payment_zone, :payment_zone_id, :payment_address_format, :payment_method, :payment_code, :shipping_firstname, :shipping_lastname, :shipping_company, :shipping_address_1, :shipping_address_2, :shipping_city, :shipping_postcode, :shipping_country, :shipping_country_id, :shipping_zone, :shipping_zone_id, :shipping_address_format, :shipping_method, :shipping_code, :comment, :total, :order_status_id, :affiliate_id, :commission, :language_id, :currency_id, :currency_code, :currency_value, :ip, :forwarded_ip, :user_agent, :accept_language, :date_added, :date_modified, :shipping_option_id, :address_id, :order_sn, :payment_sn)
    end
end
