class HzCompaniesController < ApplicationController
  before_action :set_hz_company, only: [:show, :edit, :update, :destroy]

  # GET /hz_companies
  # GET /hz_companies.json
  def index
    @hz_companies = HzCompany.all
  end

  # GET /hz_companies/1
  # GET /hz_companies/1.json
  def show
  end

  # GET /hz_companies/new
  def new
    @hz_company = HzCompany.new
    @custom = HzDomesticPorts.all
  end

  # GET /hz_companies/1/edit
  def edit
  end

  # POST /hz_companies
  # POST /hz_companies.json
  def create
    @hz_company = HzCompany.new(hz_company_params)

    respond_to do |format|
      if @hz_company.save
        format.html { redirect_to @hz_company, notice: 'Hz company was successfully created.' }
        format.json { render action: 'show', status: :created, location: @hz_company }
      else
        format.html { render action: 'new' }
        format.json { render json: @hz_company.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /hz_companies/1
  # PATCH/PUT /hz_companies/1.json
  def update
    respond_to do |format|
      if @hz_company.update(hz_company_params)
        format.html { redirect_to @hz_company, notice: 'Hz company was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @hz_company.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hz_companies/1
  # DELETE /hz_companies/1.json
  def destroy
    @hz_company.destroy
    respond_to do |format|
      format.html { redirect_to hz_companies_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_hz_company
      @hz_company = HzCompany.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def hz_company_params
      params.require(:hz_company).permit(:company_code, :org_code, :company_name, :company_type, :company_address, :registered_capital, :total_investment, :business_cope, :contact_person, :contact_info, :fax_no, :zipcode, :website_url, :email, :custom_code)
    end
end
