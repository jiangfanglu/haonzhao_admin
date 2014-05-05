require 'test_helper'

class FeaturedShopsControllerTest < ActionController::TestCase
  setup do
    @featured_shop = featured_shops(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:featured_shops)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create featured_shop" do
    assert_difference('FeaturedShop.count') do
      post :create, featured_shop: { manufacturer_id: @featured_shop.manufacturer_id, store_id: @featured_shop.store_id }
    end

    assert_redirected_to featured_shop_path(assigns(:featured_shop))
  end

  test "should show featured_shop" do
    get :show, id: @featured_shop
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @featured_shop
    assert_response :success
  end

  test "should update featured_shop" do
    patch :update, id: @featured_shop, featured_shop: { manufacturer_id: @featured_shop.manufacturer_id, store_id: @featured_shop.store_id }
    assert_redirected_to featured_shop_path(assigns(:featured_shop))
  end

  test "should destroy featured_shop" do
    assert_difference('FeaturedShop.count', -1) do
      delete :destroy, id: @featured_shop
    end

    assert_redirected_to featured_shops_path
  end
end
