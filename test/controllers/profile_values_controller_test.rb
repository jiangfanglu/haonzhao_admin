require 'test_helper'

class ProfileValuesControllerTest < ActionController::TestCase
  setup do
    @profile_value = profile_values(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:profile_values)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create profile_value" do
    assert_difference('ProfileValue.count') do
      post :create, profile_value: { alias: @profile_value.alias, name: @profile_value.name, profile_id: @profile_value.profile_id }
    end

    assert_redirected_to profile_value_path(assigns(:profile_value))
  end

  test "should show profile_value" do
    get :show, id: @profile_value
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @profile_value
    assert_response :success
  end

  test "should update profile_value" do
    patch :update, id: @profile_value, profile_value: { alias: @profile_value.alias, name: @profile_value.name, profile_id: @profile_value.profile_id }
    assert_redirected_to profile_value_path(assigns(:profile_value))
  end

  test "should destroy profile_value" do
    assert_difference('ProfileValue.count', -1) do
      delete :destroy, id: @profile_value
    end

    assert_redirected_to profile_values_path
  end
end
