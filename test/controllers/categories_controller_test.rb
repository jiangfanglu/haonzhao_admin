require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase
  setup do
    @category = categories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:categories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create category" do
    assert_difference('Category.count') do
      post :create, category: { column: @category.column, date_added: @category.date_added, date_modified: @category.date_modified, description: @category.description, image: @category.image, meta_description: @category.meta_description, meta_keyword: @category.meta_keyword, name: @category.name, parent_id: @category.parent_id, sort_order: @category.sort_order, status: @category.status, top: @category.top }
    end

    assert_redirected_to category_path(assigns(:category))
  end

  test "should show category" do
    get :show, id: @category
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @category
    assert_response :success
  end

  test "should update category" do
    patch :update, id: @category, category: { column: @category.column, date_added: @category.date_added, date_modified: @category.date_modified, description: @category.description, image: @category.image, meta_description: @category.meta_description, meta_keyword: @category.meta_keyword, name: @category.name, parent_id: @category.parent_id, sort_order: @category.sort_order, status: @category.status, top: @category.top }
    assert_redirected_to category_path(assigns(:category))
  end

  test "should destroy category" do
    assert_difference('Category.count', -1) do
      delete :destroy, id: @category
    end

    assert_redirected_to categories_path
  end
end
