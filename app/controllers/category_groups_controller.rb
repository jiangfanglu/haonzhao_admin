class CategoryGroupsController < ApplicationController
  before_action :set_category_group, only: [:show, :edit, :update, :destroy]

  # GET /category_groups
  # GET /category_groups.json
  def index
    @category_groups = CategoryGroup.includes(:category_description).includes(:categorynavgroup).all
  end

  # GET /category_groups/1
  # GET /category_groups/1.json
  def show
  end

  # GET /category_groups/new
  def new
    @category_group = CategoryGroup.new
    @category = CategoryDescription.joins(:category).where("parent_id = 0 AND status = 1")
    @groups = Categorynavgroup.all
  end

  # GET /category_groups/1/edit
  def edit
    @category = CategoryDescription.joins(:category).where("parent_id = 0")
    @groups = Categorynavgroup.all
  end

  # POST /category_groups
  # POST /category_groups.json
  def create
    @category_group = CategoryGroup.new(category_group_params)

    respond_to do |format|
      if @category_group.save
        format.html { redirect_to @category_group, notice: 'Category group was successfully created.' }
        format.json { render action: 'show', status: :created, location: @category_group }
      else
        format.html { render action: 'new' }
        format.json { render json: @category_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /category_groups/1
  # PATCH/PUT /category_groups/1.json
  def update
    respond_to do |format|
      if @category_group.update(category_group_params)
        format.html { redirect_to @category_group, notice: 'Category group was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @category_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /category_groups/1
  # DELETE /category_groups/1.json
  def destroy
    @category_group.destroy
    respond_to do |format|
      format.html { redirect_to category_groups_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category_group
      @category_group = CategoryGroup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_group_params
      params.require(:category_group).permit(:category_id, :group_id)
    end
end
