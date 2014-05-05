class FeaturedShopsController < ApplicationController
  before_action :set_featured_shop, only: [:show, :edit, :update, :destroy]

  # GET /featured_shops
  # GET /featured_shops.json
  def index
    @featured_shops = FeaturedShop.all
  end

  # GET /featured_shops/1
  # GET /featured_shops/1.json
  def show
  end

  # GET /featured_shops/new
  def new
    @featured_shop = FeaturedShop.new
  end

  # GET /featured_shops/1/edit
  def edit
  end

  # POST /featured_shops
  # POST /featured_shops.json
  def create
    @featured_shop = FeaturedShop.new(featured_shop_params)

    respond_to do |format|
      if @featured_shop.save
        format.html { redirect_to @featured_shop, notice: 'Featured shop was successfully created.' }
        format.json { render action: 'show', status: :created, location: @featured_shop }
      else
        format.html { render action: 'new' }
        format.json { render json: @featured_shop.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /featured_shops/1
  # PATCH/PUT /featured_shops/1.json
  def update
    respond_to do |format|
      if @featured_shop.update(featured_shop_params)
        format.html { redirect_to @featured_shop, notice: 'Featured shop was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @featured_shop.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /featured_shops/1
  # DELETE /featured_shops/1.json
  def destroy
    @featured_shop.destroy
    respond_to do |format|
      format.html { redirect_to featured_shops_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_featured_shop
      @featured_shop = FeaturedShop.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def featured_shop_params
      params.require(:featured_shop).permit(:manufacturer_id, :store_id)
    end
end
