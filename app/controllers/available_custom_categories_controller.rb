class AvailableCustomCategoriesController < ApplicationController
  before_action :set_available_custom_category, only: [:show, :edit, :update, :destroy]

  # GET /available_custom_categories
  # GET /available_custom_categories.json
  def index
    @available_custom_categories = AvailableCustomCategory.all
  end

  # GET /available_custom_categories/1
  # GET /available_custom_categories/1.json
  def show
  end

  # GET /available_custom_categories/new
  def new
    @available_custom_category = AvailableCustomCategory.new
  end

  # GET /available_custom_categories/1/edit
  def edit
  end

  # POST /available_custom_categories
  # POST /available_custom_categories.json
  def create
    @available_custom_category = AvailableCustomCategory.new(available_custom_category_params)

    respond_to do |format|
      if @available_custom_category.save
        format.html { redirect_to @available_custom_category, notice: 'Available custom category was successfully created.' }
        format.json { render action: 'show', status: :created, location: @available_custom_category }
      else
        format.html { render action: 'new' }
        format.json { render json: @available_custom_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /available_custom_categories/1
  # PATCH/PUT /available_custom_categories/1.json
  def update
    respond_to do |format|
      if @available_custom_category.update(available_custom_category_params)
        format.html { redirect_to @available_custom_category, notice: 'Available custom category was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @available_custom_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /available_custom_categories/1
  # DELETE /available_custom_categories/1.json
  def destroy
    @available_custom_category.destroy
    respond_to do |format|
      format.html { redirect_to available_custom_categories_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_available_custom_category
      @available_custom_category = AvailableCustomCategory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def available_custom_category_params
      params.require(:available_custom_category).permit(:category_id, :sort_order)
    end
end
