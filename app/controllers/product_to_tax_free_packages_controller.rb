class ProductToTaxFreePackagesController < ApplicationController
  before_action :set_product_to_tax_free_package, only: [:show, :edit, :update, :destroy]

  # GET /product_to_tax_free_packages
  # GET /product_to_tax_free_packages.json
  def index
    @product_to_tax_free_packages = ProductToTaxFreePackage.all
  end

  # GET /product_to_tax_free_packages/1
  # GET /product_to_tax_free_packages/1.json
  def show
  end

  # GET /product_to_tax_free_packages/new
  def new
    @product_to_tax_free_package = ProductToTaxFreePackage.new
  end

  # GET /product_to_tax_free_packages/1/edit
  def edit
  end

  # POST /product_to_tax_free_packages
  # POST /product_to_tax_free_packages.json
  def create
    @product_to_tax_free_package = ProductToTaxFreePackage.new(product_to_tax_free_package_params)

    respond_to do |format|
      if @product_to_tax_free_package.save
        format.html { redirect_to @product_to_tax_free_package, notice: 'Product to tax free package was successfully created.' }
        format.json { render action: 'show', status: :created, location: @product_to_tax_free_package }
      else
        format.html { render action: 'new' }
        format.json { render json: @product_to_tax_free_package.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /product_to_tax_free_packages/1
  # PATCH/PUT /product_to_tax_free_packages/1.json
  def update
    respond_to do |format|
      if @product_to_tax_free_package.update(product_to_tax_free_package_params)
        format.html { redirect_to @product_to_tax_free_package, notice: 'Product to tax free package was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @product_to_tax_free_package.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /product_to_tax_free_packages/1
  # DELETE /product_to_tax_free_packages/1.json
  def destroy
    @product_to_tax_free_package.destroy
    respond_to do |format|
      format.html { redirect_to product_to_tax_free_packages_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product_to_tax_free_package
      @product_to_tax_free_package = ProductToTaxFreePackage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_to_tax_free_package_params
      params.require(:product_to_tax_free_package).permit(:package_id, :product_id,:quantity)
    end
end
