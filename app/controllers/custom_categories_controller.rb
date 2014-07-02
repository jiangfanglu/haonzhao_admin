class CustomCategoriesController < ApplicationController
  before_action :set_custom_category, only: [:show, :edit, :update, :destroy]

  # GET /custom_categories
  # GET /custom_categories.json
  def index
    @custom_categories = CustomCategory.order('created_at DESC').paginate per_page: 20, page: params[:page]
  end

  # GET /custom_categories/1
  # GET /custom_categories/1.json
  def show
    # @category = Category.find params[:id]
  end

  # GET /custom_categories/new
  def new
    @custom_category = CustomCategory.new
  end

  # GET /custom_categories/1/edit
  def edit
  end

  # POST /custom_categories
  # POST /custom_categories.json
  def create
    @custom_category = CustomCategory.new(custom_category_params)

    respond_to do |format|
      if @custom_category.save
        format.html { redirect_to @custom_category, notice: 'Custom category was successfully created.' }
        format.json { render action: 'show', status: :created, location: @custom_category }
      else
        format.html { render action: 'new' }
        format.json { render json: @custom_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /custom_categories/1
  # PATCH/PUT /custom_categories/1.json
  def update
    respond_to do |format|
      if @custom_category.update(custom_category_params)
        format.html { redirect_to @custom_category, notice: 'Custom category was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @custom_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /custom_categories/1
  # DELETE /custom_categories/1.json
  def destroy
    @custom_category.destroy
    respond_to do |format|
      format.html { redirect_to custom_categories_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_custom_category
      @custom_category = CustomCategory.find(params[:id])
      # @custom_category = Category.find params[:id]
      
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def custom_category_params
      params.require(:custom_category).permit(:category_id)
    end
end
