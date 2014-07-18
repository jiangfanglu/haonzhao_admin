class ProductsController < ApplicationController
  include ApplicationHelper
  before_action :set_product, only: [:show, :edit, :update, :destroy, :active, :inactive]

  # GET /products
  # GET /products.json
  def index
    @products = Product.order('product_id DESC').paginate page: params[:page], per_page: 20
  end

  # GET /products/1
  # GET /products/1.json
  def show
  end

  # # GET /products/new
  def new
    @product = Product.new
    @shops = Shop.where("register_type = 2")
    @categories = Category.includes(:category_description).where("status = 1")
    #@product_stock_status = StockStatus.where("name = 'In Stock'").first.stock_status_id
  end

  # # GET /products/1/edit
  # def edit
  # end
  
  def active
    respond_to do |format|
      if @product.update_attribute :status, true
        format.html { redirect_to @product, notice: 'Product was active.' }
        format.json { head :no_content }
      else
        format.html { render action: 'show' }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def inactive
    respond_to do |format|
      if @product.update_attribute :status, false
        format.html { redirect_to @product, notice: 'Product was inactive.' }
        format.json { head :no_content }
      else
        format.html { render action: 'show' }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def newp

  end

  # # POST /products
  # # POST /products.json
  # def create
  #   @product = Product.new(product_params)
  # 
  #   respond_to do |format|
  #     if @product.save
  #       format.html { redirect_to @product, notice: 'Product was successfully created.' }
  #       format.json { render action: 'show', status: :created, location: @product }
  #     else
  #       format.html { render action: 'new' }
  #       format.json { render json: @product.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # # PATCH/PUT /products/1
  # # PATCH/PUT /products/1.json
  # def update
  #   respond_to do |format|
  #     if @product.update(product_params)
  #       format.html { redirect_to @product, notice: 'Product was successfully updated.' }
  #       format.json { head :no_content }
  #     else
  #       format.html { render action: 'edit' }
  #       format.json { render json: @product.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:model, :sku, :upc, :ean, :jan, :isbn, :mpn, :location, :quantity, :stock_status_id, :image, :manufacturer_id, :shipping, :price, :points, :tax_class_id, :date_available, :weight, :weight_class_id, :length, :width, :height, :length_class_id, :subtract, :minimum, :sort_order, :status, :date_added, :date_modified, :viewed, :name, :description, :meta_description, :meta_keyword)
    end
end
