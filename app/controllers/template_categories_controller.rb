class TemplateCategoriesController < ApplicationController
  before_action :set_template_category, only: [:show, :edit, :update, :destroy]

  # GET /template_categories
  # GET /template_categories.json
  def index
    @template_categories = TemplateCategory.all
  end

  # GET /template_categories/1
  # GET /template_categories/1.json
  def show
  end

  # GET /template_categories/new
  def new
    @template_category = TemplateCategory.new
  end

  # GET /template_categories/1/edit
  def edit
  end

  # POST /template_categories
  # POST /template_categories.json
  def create
    @template_category = TemplateCategory.new(template_category_params)

    respond_to do |format|
      if @template_category.save
        format.html { redirect_to @template_category, notice: 'Template category was successfully created.' }
        format.json { render action: 'show', status: :created, location: @template_category }
      else
        format.html { render action: 'new' }
        format.json { render json: @template_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /template_categories/1
  # PATCH/PUT /template_categories/1.json
  def update
    respond_to do |format|
      if @template_category.update(template_category_params)
        format.html { redirect_to @template_category, notice: 'Template category was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @template_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /template_categories/1
  # DELETE /template_categories/1.json
  def destroy
    @template_category.destroy
    respond_to do |format|
      format.html { redirect_to template_categories_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_template_category
      @template_category = TemplateCategory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def template_category_params
      params.require(:template_category).permit(:name, :sort_order)
    end
end
