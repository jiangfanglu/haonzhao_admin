require 'test_helper'

class ContentProductsControllerTest < ActionController::TestCase
  setup do
    @content_product = content_products(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:content_products)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create content_product" do
    assert_difference('ContentProduct.count') do
      post :create, content_product: { country_code: @content_product.country_code, meta_description: @content_product.meta_description, product_id: @content_product.product_id, tags: @content_product.tags, title: @content_product.title, video: @content_product.video }
    end

    assert_redirected_to content_product_path(assigns(:content_product))
  end

  test "should show content_product" do
    get :show, id: @content_product
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @content_product
    assert_response :success
  end

  test "should update content_product" do
    patch :update, id: @content_product, content_product: { country_code: @content_product.country_code, meta_description: @content_product.meta_description, product_id: @content_product.product_id, tags: @content_product.tags, title: @content_product.title, video: @content_product.video }
    assert_redirected_to content_product_path(assigns(:content_product))
  end

  test "should destroy content_product" do
    assert_difference('ContentProduct.count', -1) do
      delete :destroy, id: @content_product
    end

    assert_redirected_to content_products_path
  end
end
