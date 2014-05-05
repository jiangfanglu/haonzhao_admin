require 'test_helper'

class FeaturedProductsControllerTest < ActionController::TestCase
  setup do
    @featured_product = featured_products(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:featured_products)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create featured_product" do
    assert_difference('FeaturedProduct.count') do
      post :create, featured_product: { product_id: @featured_product.product_id, store_id: @featured_product.store_id }
    end

    assert_redirected_to featured_product_path(assigns(:featured_product))
  end

  test "should show featured_product" do
    get :show, id: @featured_product
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @featured_product
    assert_response :success
  end

  test "should update featured_product" do
    patch :update, id: @featured_product, featured_product: { product_id: @featured_product.product_id, store_id: @featured_product.store_id }
    assert_redirected_to featured_product_path(assigns(:featured_product))
  end

  test "should destroy featured_product" do
    assert_difference('FeaturedProduct.count', -1) do
      delete :destroy, id: @featured_product
    end

    assert_redirected_to featured_products_path
  end
end
