require 'test_helper'

class AvailableCustomCategoriesControllerTest < ActionController::TestCase
  setup do
    @available_custom_category = available_custom_categories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:available_custom_categories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create available_custom_category" do
    assert_difference('AvailableCustomCategory.count') do
      post :create, available_custom_category: { category_id: @available_custom_category.category_id, sort_order: @available_custom_category.sort_order }
    end

    assert_redirected_to available_custom_category_path(assigns(:available_custom_category))
  end

  test "should show available_custom_category" do
    get :show, id: @available_custom_category
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @available_custom_category
    assert_response :success
  end

  test "should update available_custom_category" do
    patch :update, id: @available_custom_category, available_custom_category: { category_id: @available_custom_category.category_id, sort_order: @available_custom_category.sort_order }
    assert_redirected_to available_custom_category_path(assigns(:available_custom_category))
  end

  test "should destroy available_custom_category" do
    assert_difference('AvailableCustomCategory.count', -1) do
      delete :destroy, id: @available_custom_category
    end

    assert_redirected_to available_custom_categories_path
  end
end
