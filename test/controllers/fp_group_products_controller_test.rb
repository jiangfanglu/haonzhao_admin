require 'test_helper'

class FpGroupProductsControllerTest < ActionController::TestCase
  setup do
    @fp_group_product = fp_group_products(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:fp_group_products)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create fp_group_product" do
    assert_difference('FpGroupProduct.count') do
      post :create, fp_group_product: { group_id: @fp_group_product.group_id, product_id: @fp_group_product.product_id }
    end

    assert_redirected_to fp_group_product_path(assigns(:fp_group_product))
  end

  test "should show fp_group_product" do
    get :show, id: @fp_group_product
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @fp_group_product
    assert_response :success
  end

  test "should update fp_group_product" do
    patch :update, id: @fp_group_product, fp_group_product: { group_id: @fp_group_product.group_id, product_id: @fp_group_product.product_id }
    assert_redirected_to fp_group_product_path(assigns(:fp_group_product))
  end

  test "should destroy fp_group_product" do
    assert_difference('FpGroupProduct.count', -1) do
      delete :destroy, id: @fp_group_product
    end

    assert_redirected_to fp_group_products_path
  end
end
