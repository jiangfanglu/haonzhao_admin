class ShopsController < ApplicationController
  include ApplicationHelper
  before_action :set_shop, only: [:show, :edit, :update, :destroy, :close, :allow]
  skip_before_filter :login?, only: [:login, :login_check]

  # GET /shops
  # GET /shops.json
  def index
    @shops = Shop.paginate page: params[:page], per_page: 20, order: 'manufacturer_id DESC'
  end

  # GET /shops/1
  # GET /shops/1.json
  def show
  end

  # GET /shops/1/edit
  def edit
  end
  
  def login
    @admin = Admin.new
  end
  
  def login_check
    @user = Admin.find_by_email params[:admin][:email]
    url = {action: :index}
    authenticate(@user, params[:admin][:password]) ? session[:user] = @user.id : url = {action: :login}
    
    redirect_to url
  end
  
  def close
    respond_to do |format|
      if @shop.close
        format.html { render text: 'SUCCESS' }
        format.json { render json: 'SUCCESS'.to_json }
      else
        format.json { render json: @shop.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def allow
    respond_to do |format|
      if @shop.allow
        format.html { render text: 'SUCCESS' }
        format.json { render json: 'SUCCESS'.to_json }
      else
        format.json { render json: @shop.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /shops/1
  # PATCH/PUT /shops/1.json
  def update
    respond_to do |format|
      if @shop.update(shop_params)
        format.html { redirect_to @shop, notice: 'Shop was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @shop.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shops/1
  # DELETE /shops/1.json
  def destroy
    @shop.destroy
    respond_to do |format|
      format.html { redirect_to shops_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shop
      @shop = Shop.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def shop_params
      params.require(:shop).permit(:name, :image, :identity_no, :business_rego_no, :business_name, :organization_no, :register_type, :shipping_option_id)
    end
end
