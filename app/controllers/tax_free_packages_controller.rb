class TaxFreePackagesController < ApplicationController
  before_action :set_tax_free_package, only: [:show, :edit, :update, :destroy]

  # GET /tax_free_packages
  # GET /tax_free_packages.json
  def index
    @tax_free_packages = TaxFreePackage.all
  end

  # GET /tax_free_packages/1
  # GET /tax_free_packages/1.json
  def show
  end

  # GET /tax_free_packages/new
  def new
    @tax_free_package = TaxFreePackage.new
  end

  # GET /tax_free_packages/1/edit
  def edit
  end

  # POST /tax_free_packages
  # POST /tax_free_packages.json
  def create
    @tax_free_package = TaxFreePackage.new(tax_free_package_params)

    respond_to do |format|
      if @tax_free_package.save
        format.html { redirect_to @tax_free_package, notice: 'Tax free package was successfully created.' }
        format.json { render action: 'show', status: :created, location: @tax_free_package }
      else
        format.html { render action: 'new' }
        format.json { render json: @tax_free_package.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tax_free_packages/1
  # PATCH/PUT /tax_free_packages/1.json
  def update
    respond_to do |format|
      if @tax_free_package.update(tax_free_package_params)
        format.html { redirect_to @tax_free_package, notice: 'Tax free package was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @tax_free_package.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tax_free_packages/1
  # DELETE /tax_free_packages/1.json
  def destroy
    @tax_free_package.destroy
    respond_to do |format|
      format.html { redirect_to tax_free_packages_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tax_free_package
      @tax_free_package = TaxFreePackage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tax_free_package_params
      params.require(:tax_free_package).permit(:name, :description, :purchase_count, :viewed, :supplier_id)
    end
end
