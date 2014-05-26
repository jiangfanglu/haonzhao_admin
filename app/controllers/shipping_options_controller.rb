class ShippingOptionsController < ApplicationController
  before_action :set_shipping_option, only: [:show, :edit, :update, :destroy]

  # GET /shipping_options
  # GET /shipping_options.json
  def index
    @shipping_options = ShippingOption.all
  end

  # GET /shipping_options/1
  # GET /shipping_options/1.json
  def show
  end

  # GET /shipping_options/new
  def new
    @shipping_option = ShippingOption.new
  end

  # GET /shipping_options/1/edit
  def edit
  end

  # POST /shipping_options
  # POST /shipping_options.json
  def create
    @shipping_option = ShippingOption.new(shipping_option_params)

    respond_to do |format|
      if @shipping_option.save
        format.html { redirect_to @shipping_option, notice: 'Shipping option was successfully created.' }
        format.json { render action: 'show', status: :created, location: @shipping_option }
      else
        format.html { render action: 'new' }
        format.json { render json: @shipping_option.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /shipping_options/1
  # PATCH/PUT /shipping_options/1.json
  def update
    respond_to do |format|
      if @shipping_option.update(shipping_option_params)
        format.html { redirect_to @shipping_option, notice: 'Shipping option was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @shipping_option.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shipping_options/1
  # DELETE /shipping_options/1.json
  def destroy
    @shipping_option.destroy
    respond_to do |format|
      format.html { redirect_to shipping_options_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shipping_option
      @shipping_option = ShippingOption.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def shipping_option_params
      params.require(:shipping_option).permit(:option_value, :shipping_id, :price)
    end
end
