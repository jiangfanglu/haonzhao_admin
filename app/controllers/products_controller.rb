class ProductsController < ApplicationController
  include ApplicationHelper
  before_action :set_product, only: [:show, :edit, :update, :destroy, :active, :inactive]
  skip_before_filter  :verify_authenticity_token, only: [:upload_user_account_images]
  # GET /products
  # GET /products.json
  def index
    @products = Product.includes(:product_description).order('product_id DESC').paginate page: params[:page], per_page: 20
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
    @attribute_groups = AttributeGroupDescription.order("name asc").all.uniq_by(&:name)
    @countries = HzCountry.all.order("name asc")
    #@product_stock_status = StockStatus.where("name = 'In Stock'").first.stock_status_id
    @hz_companies = HzCompany.all
    @post_taxes = HzPostTax.all
    @units = HzUnit.all
    @purposes = HzPurpose.all
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

  def attributes
    @attributes = AttributeDescription.joins(:select_attribute).where("oc_attribute.attribute_group_id = ?", params[:id])
    respond_to do |format|
      format.html { render layout: false }
    end
  end

  # # POST /products
  # # POST /products.json
  def create
    @product = Product.new(
        :model=>params[:product][:model], 
        :sku=>params[:product][:sku], 
        :upc=>params[:product][:upc], 
        :ean=>params[:product][:ean], 
        :jan=>params[:product][:jan], 
        :isbn=>params[:product][:isbn], 
        :mpn=>params[:product][:mpn], 
        :location=>params[:product][:location], 
        :quantity=>params[:product][:quantity], 
        :stock_status_id=>params[:product][:stock_status_id], 
        :image=>"", 
        :manufacturer_id=>params[:product][:manufacturer_id], 
        :shipping=>params[:product][:shipping], 
        :price=>params[:product][:price], 
        :points=>params[:product][:points], 
        :tax_class_id=>params[:product][:tax_class_id], 
        :date_available=>params[:product][:date_available], 
        :weight=>params[:product][:weight], 
        :weight_class_id=>params[:product][:weight_class_id], 
        :length=>params[:product][:length], 
        :width=>params[:product][:width], 
        :height=>params[:product][:height], 
        :length_class_id=>params[:product][:length_class_id], 
        :subtract=>params[:product][:subtract], 
        :minimum=>params[:product][:minimum], 
        :sort_order=>params[:product][:sort_order], 
        :status=>params[:product][:status], 
        :date_added=>Time.now, 
        :date_modified=>Time.now,
        :viewed=>params[:product][:viewed]
      )
    @shop_id = params[:product][:manufacturer_id].to_i
    main_image_filename = upload_product_image(params[:product][:image],@shop_id)[:basic_file_name]
    @product.image = main_image_filename

    respond_to do |format|
      if @product.save
          @product_description = ProductDescription.new
          @product_description.save_info(@product.product_id, params[:products][:name],params[:products][:description],params[:products][:meta_description],params[:products][:meta_keyword],params[:products][:meta_keyword])
          @product_description.save

          @product_image = ProductImage.new
          @product_image.save_info(@product.product_id,main_image_filename,0)
          @product_image.save

          unless params[:product_images].blank?
            n=1
            params[:product_images].each do |f|
              uploaded_response = upload_product_image(f,@shop_id)
              unless uploaded_response[:store_aliyunoss_fail]
                  @product_image = ProductImage.new
                  @product_image.save_info(@product.product_id,uploaded_response[:basic_file_name],n)
                  @product_image.save
                  n+=1
              end
            end
          end
          unless params[:discount].blank?
            params[:discount].each do |d|
              @product_discount = ProductDiscount.new
              @product_discount.save_info(@product.product_id,0,d[:quantity].to_i,d[:priority].to_i,d[:price].to_f,d[:start],d[:end])
              @product_discount.save
            end
          end
          unless params[:attribute].blank?
            params[:attribute].each do |pa|
                @product_attribute = ProductAttribute.new
                @product_attribute.save_info(@product.product_id,pa.split("_")[0].to_i,pa.split("_")[1])
                @product_attribute.save
            end
          end
          params[:products][:categories].each do |cat|
            unless cat.blank?
              @product_to_category = ProductToCategory.new
              @product_to_category.save_info(@product.product_id,cat.to_i)
              @product_to_category.save

              @shop_category = ShopCategory.new
              @shop_category.save_info(@shop_id,cat.to_i)
              @shop_category.save
            end
          end

          @hz_product = HzProduct.new(
              :barcode=>params[:hz][:barcode],
              :post_tax_no=>params[:hz][:post_tax_no],
              :material_address=>params[:hz][:material_address],
              :unit_code=>params[:hz][:unit],
              :hz_purpose_code=>params[:hz][:purpose],
              :standard=>params[:hz][:standard],
              :main_elements=>params[:hz][:main_elements],
              :product_id=>@product.product_id,
              :hz_company_id=>params[:hz][:hz_company_id]
            )
          @hz_product.save

        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render action: 'show', status: :created, location: @product }
      else
        format.html { render action: 'new' }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end


# {"utf8"=>"✓", "authenticity_token"=>"tQKHfI6YTxVW09bR5eXn/uA5r/YgmETeqeS1wWUuzQE=", 
# "product"=>{"name"=>"adasdasdsadasd", "description"=>"<p>adasd</p>\r\n", "meta_description"=>"asdasd", "meta_keyword"=>"asdasd", 
# "model"=>"12321", "quantity"=>"20", "price"=>"100.0", "points"=>"0", "date_available"=>"07/31/2014", "sku"=>"", "upc"=>"", "ean"=>"", "jan"=>"", "isbn"=>"", "mpn"=>"", "weight"=>"0", "length"=>"0", "width"=>"0", "height"=>"0", "location"=>"上海", "stock_status_id"=>"7", "shipping"=>"true", "tax_class_id"=>"9", "weight_class_id"=>"0", "subtract"=>"true", "length_class_id"=>"0", "minimum"=>"1", "sort_order"=>"0", "status"=>"true", "viewed"=>"0", "date_added"=>"2014-07-25 14:09:31 +0800", "date_modified"=>"2014-07-25 14:09:31 +0800", "manufacturer_id"=>"709", "image"=>#<ActionDispatch::Http::UploadedFile:0x0000000624ee00 @tempfile=#<File:/tmp/RackMultipart20140725-25046-17p73ov>, @original_filename="2505-110QG10I351.jpg", @content_type="image/jpeg", @headers="Content-Disposition: form-data; name=\"product[image]\"; filename=\"2505-110QG10I351.jpg\"\r\nContent-Type: image/jpeg\r\n">}, 
# "products"=>{"categories"=>["", "83"], "attribute_groups"=>"131"}, 
# "product_images"=>[#<ActionDispatch::Http::UploadedFile:0x00000006250ca0 @tempfile=#<File:/tmp/RackMultipart20140725-25046-1ufyr7c>, @original_filename="original_CW.jpg", @content_type="image/jpeg", @headers="Content-Disposition: form-data; name=\"product_images[]\"; filename=\"original_CW.jpg\"\r\nContent-Type: image/jpeg\r\n">, #<ActionDispatch::Http::UploadedFile:0x00000006250d18 @tempfile=#<File:/tmp/RackMultipart20140725-25046-15qwa99>, @original_filename="2505-110QG10I351.jpg", @content_type="image/jpeg", @headers="Content-Disposition: form-data; name=\"product_images[]\"; filename=\"2505-110QG10I351.jpg\"\r\nContent-Type: image/jpeg\r\n">], 
# "discount"=>[{"quantity"=>"1", "price"=>"0.0", "priority"=>"0", "start"=>"2014-07-25 14:46:05", "end"=>"2014-07-25 14:46:05"}], 
# "attribute_group"=>["147", "131"], "attribute"=>["1177", "1018"]}




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

  def upload_user_account_images
    @success = true
    foldername = "#{USER_UPLOADS}#{current_user.id}/"
    filename = Base64.encode64(Marshal.dump({:user_id=>current_user.id,:date_time=>Time.new.to_i})).gsub(/\n/,'')

    filepath = upload_image_basic_with_filename(params[:upload], filename, foldername)
    if filepath != "FAILED"
      uu = UserUpload.new
      uu.filename = filepath
      uu.filesize = 0
      uu.user_id = current_user.id
      begin
        uu.save!
      rescue Exception => e
        logger.debug e.message
      end
      @success = true
      @url = "#{MEIDIA_SERVER}/#{BUCKET_NAME}/#{foldername}#{filepath}"
    else
      @success = false
    end
    @callback = params[:CKEditorFuncNum]
    render :layout=>false
  end

  def browse_user_images
    @user_uploads = UserUpload.where("user_id = ?", current_user.id)

    @images = []
    @user_uploads.each do |uu|
      @images.append({
          "image"=> "#{MEIDIA_SERVER}/#{BUCKET_NAME}/#{USER_UPLOADS}#{current_user.id}/#{uu.filename}",
          "thumb"=> "#{MEIDIA_SERVER}/#{BUCKET_NAME}/#{USER_UPLOADS}#{current_user.id}/#{uu.filename}",
          "folder"=> "#{MEIDIA_SERVER}/#{BUCKET_NAME}/#{USER_UPLOADS}#{current_user.id}"
        })
    end
    render :json=>@images.to_json, :layout=>false
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

    def upload_image_basic_with_filename(f, filename, foldername)
      tmp = f.tempfile
      ext = File.extname(f.original_filename)

      basic_file_name = "#{filename}#{ext}".downcase

      # logger.debug basic_file_name

      image = MiniMagick::Image.open(tmp.path)

      # PUT files to Aliyun OSS code here start
        store_aliyunoss_fail = false
        begin
        response = Aliyun::OSS::OSSObject.store(
          "#{foldername}#{basic_file_name}",
          open(tmp.path),
          BUCKET_NAME)
      rescue Aliyun::OSS::ResponseError => error
        puts "#{error.code}:#{error.message}"
      end

      if not response.success?
          store_aliyunoss_fail = true
         return "FAILED"
    else
      return basic_file_name
      end
      # Aliyun OSS code finish
    end
end
