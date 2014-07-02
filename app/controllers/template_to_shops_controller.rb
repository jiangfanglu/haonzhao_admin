class TemplateToShopsController < ApplicationController
  before_action :set_template_to_shop, only: [:show, :edit, :update, :destroy]

  # GET /template_to_shops
  # GET /template_to_shops.json
  def index
    @template_to_shops = TemplateToShop.all
  end

  # GET /template_to_shops/1
  # GET /template_to_shops/1.json
  def show
  end

  # GET /template_to_shops/new
  def new
    @template_to_shop = TemplateToShop.new
  end

  # GET /template_to_shops/1/edit
  def edit
  end

  # POST /template_to_shops
  # POST /template_to_shops.json
  def create
    @template_to_shop = TemplateToShop.new(template_to_shop_params)

    respond_to do |format|
      if @template_to_shop.save
        format.html { redirect_to @template_to_shop, notice: 'Template to shop was successfully created.' }
        format.json { render action: 'show', status: :created, location: @template_to_shop }
      else
        format.html { render action: 'new' }
        format.json { render json: @template_to_shop.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /template_to_shops/1
  # PATCH/PUT /template_to_shops/1.json
  def update
    respond_to do |format|
      if @template_to_shop.update(template_to_shop_params)
        format.html { redirect_to @template_to_shop, notice: 'Template to shop was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @template_to_shop.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /template_to_shops/1
  # DELETE /template_to_shops/1.json
  def destroy
    @template_to_shop.destroy
    respond_to do |format|
      format.html { redirect_to template_to_shops_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_template_to_shop
      @template_to_shop = TemplateToShop.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def template_to_shop_params
      params.require(:template_to_shop).permit(:shop_id, :template_id)
    end
end
