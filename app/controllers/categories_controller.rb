class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy, :edit_attributes, :new_attribute_group]

  # GET /categories
  # GET /categories.json
  def index
    @categories = Category.where(parent_id: 0).order('category_id DESC')
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
    @categories = @category.children
  end

  # GET /categories/new
  def new
    @category = Category.new(parent_id: params[:pid])
  end

  # GET /categories/1/edit
  def edit
  end

  # POST /categories
  # POST /categories.json
  def create
    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        format.html { redirect_to @category, notice: 'Category was successfully created.' }
        format.json { render action: 'show', status: :created, location: @category }
      else
        format.html { render action: 'new' }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to @category, notice: 'Category was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @category.destroy
    respond_to do |format|
      format.html { redirect_to categories_url }
      format.json { head :no_content }
    end
  end
  
  def edit_attributes
    @attribute_groups = @category.attribute_groups
  end
  
  def new_attribute_group
    @category = Category.find params[:id]
    @attribute_group = AttributeGroup.new
    @attribute_group.category_id = @category.category_id
  end
  
  def show_attribute_group
    @attribute_group = AttributeGroup.find params[:id]
    @attribute = Attribute.new attribute_group_id: @attribute_group.attribute_group_id
  end

  def create_attribute_group
    @attribute_group = AttributeGroup.new(params[:attribute_group].merge({sort_order: 0}))
    @category = Category.find @attribute_group.category_id
    if @attribute_group.save
      @category.attribute_groups << @attribute_group
      redirect_to action: :show_attribute_group, id: @attribute_group.attribute_group_id
    else
      render :new_attribute_group
    end
  end

  def update_attribute_group
    @category_to_attribute = CategoryToAttribute.new category: @category, attribute_group: AttributeGroup.new(name: params[:name])
  end
  
  def edit_attribute
    @attribute = Attribute.find params[:id]
  end
  
  def create_attribute
    @attribute = Attribute.new params[:attribute]
    @attribute.save
    redirect_to action: :show_attribute_group, id: @attribute.attribute_group_id
  end
  
  def update_attribute
    @attribute = Attribute.find params[:attribute][:attribute_id]
    if @attribute.update_attributes(params[:attribute].except(:attribute_id))
      redirect_to action: :show_attribute_group, id: @attribute.attribute_group_id
    end
  end

  def destroy_attribute
    @attribute = Attribute.find params[:id]
    if @attribute.destroy
      redirect_to action: :show_attribute_group, id: @attribute.attribute_group_id
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params.require(:category).permit(:image, :parent_id, :top, :column, :sort_order, :status, :date_added, :date_modified, :name, :description, :meta_description, :meta_keyword)
    end
end
