class FpGroupProductsController < ApplicationController
  before_action :set_fp_group_product, only: [:show, :edit, :update, :destroy]

  # GET /fp_group_products
  # GET /fp_group_products.json
  def index
    @fp_group_products = FpGroupProduct.all
  end

  # GET /fp_group_products/1
  # GET /fp_group_products/1.json
  def show
  end

  # GET /fp_group_products/new
  def new
    @fp_group_product = FpGroupProduct.new
  end

  # GET /fp_group_products/1/edit
  def edit
  end

  # POST /fp_group_products
  # POST /fp_group_products.json
  def create
    @fp_group_product = FpGroupProduct.new(fp_group_product_params)

    respond_to do |format|
      if @fp_group_product.save
        format.html { redirect_to @fp_group_product, notice: 'Fp group product was successfully created.' }
        format.json { render action: 'show', status: :created, location: @fp_group_product }
      else
        format.html { render action: 'new' }
        format.json { render json: @fp_group_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /fp_group_products/1
  # PATCH/PUT /fp_group_products/1.json
  def update
    respond_to do |format|
      if @fp_group_product.update(fp_group_product_params)
        format.html { redirect_to @fp_group_product, notice: 'Fp group product was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @fp_group_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fp_group_products/1
  # DELETE /fp_group_products/1.json
  def destroy
    @fp_group_product.destroy
    respond_to do |format|
      format.html { redirect_to fp_group_products_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fp_group_product
      @fp_group_product = FpGroupProduct.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def fp_group_product_params
      params.require(:fp_group_product).permit(:product_id, :group_id)
    end
end
