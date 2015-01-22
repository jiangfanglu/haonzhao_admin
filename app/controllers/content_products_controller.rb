class ContentProductsController < ApplicationController
  include ApplicationHelper
  before_action :set_content_product, only: [:show, :edit, :update, :destroy]

  # GET /content_products
  # GET /content_products.json
  def index
    @content_products = ContentProduct.all
  end

  # GET /content_products/1
  # GET /content_products/1.json
  def show
  end

  # GET /content_products/new
  def new
    @content_product = ContentProduct.new
    @countries = HzCountry.all.order("name asc")
  end

  # GET /content_products/1/edit
  def edit
  end

  # POST /content_products
  # POST /content_products.json
  def create
    # @content_product = ContentProduct.new(content_product_params)
    @content_product = ContentProduct.new(
        :package_id=>params[:content_product][:package_id], 
        :title=>params[:content_product][:title], 
        :meta_description=>params[:content_product][:meta_description], 
        :country_code=>params[:content_product][:country_code], 
        :video=>params[:content_product][:video], 
        :tags=>params[:content_product][:tags], 
        :alias=>params[:content_product][:alias],
        :min_price=>params[:content_product][:min_price],
        :max_price=>params[:content_product][:max_price]
      )

    respond_to do |format|
      if @content_product.save

        unless params[:product_images].blank?
            n=0
            params[:product_images].each do |f|
              filename = Base64.encode64(Marshal.dump({:user_id=>@content_product.id,:date_time=>Time.new.to_i})).gsub(/\n/,'')
              uploaded_response = upload_image_basic_with_filename(f,filename,"featured/")
              unless uploaded_response == "FAILED"
                  @product_image = ContentProductImage.new(
                      :content_product_id=>@content_product.id,
                      :image => uploaded_response,
                      :sort_order => n
                    )
                  @product_image.save
                  n+=1
              end
            end
          end

        format.html { redirect_to @content_product, notice: 'Content product was successfully created.' }
        format.json { render action: 'show', status: :created, location: @content_product }
      else
        format.html { render action: 'new' }
        format.json { render json: @content_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /content_products/1
  # PATCH/PUT /content_products/1.json
  def update
    respond_to do |format|
      if @content_product.update(content_product_params)
        format.html { redirect_to @content_product, notice: 'Content product was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @content_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /content_products/1
  # DELETE /content_products/1.json
  def destroy
    @content_product.destroy
    respond_to do |format|
      format.html { redirect_to content_products_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_content_product
      @content_product = ContentProduct.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def content_product_params
      params.require(:content_product).permit(:product_id, :title, :meta_description, :country_code, :video, :tags)
    end
end
