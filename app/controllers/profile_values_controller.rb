class ProfileValuesController < ApplicationController
  before_action :set_profile_value, only: [:show, :edit, :update, :destroy]

  # GET /profile_values
  # GET /profile_values.json
  def index
    @profile_values = ProfileValue.all
  end

  # GET /profile_values/1
  # GET /profile_values/1.json
  def show
  end

  # GET /profile_values/new
  def new
    @profile_value = ProfileValue.new
    @profiles = Profile.all
  end

  # GET /profile_values/1/edit
  def edit
  end

  # POST /profile_values
  # POST /profile_values.json
  def create
    @profile_value = ProfileValue.new(profile_value_params)

    respond_to do |format|
      if @profile_value.save
        format.html { redirect_to @profile_value, notice: 'Profile value was successfully created.' }
        format.json { render action: 'show', status: :created, location: @profile_value }
      else
        format.html { render action: 'new' }
        format.json { render json: @profile_value.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /profile_values/1
  # PATCH/PUT /profile_values/1.json
  def update
    respond_to do |format|
      if @profile_value.update(profile_value_params)
        format.html { redirect_to @profile_value, notice: 'Profile value was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @profile_value.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /profile_values/1
  # DELETE /profile_values/1.json
  def destroy
    @profile_value.destroy
    respond_to do |format|
      format.html { redirect_to profile_values_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profile_value
      @profile_value = ProfileValue.find(params[:id])
      @profiles = Profile.all
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def profile_value_params
      params.require(:profile_value).permit(:name, :alias, :profile_id)
    end
end
