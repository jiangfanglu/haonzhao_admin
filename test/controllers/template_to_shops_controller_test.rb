require 'test_helper'

class TemplateToShopsControllerTest < ActionController::TestCase
  setup do
    @template_to_shop = template_to_shops(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:template_to_shops)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create template_to_shop" do
    assert_difference('TemplateToShop.count') do
      post :create, template_to_shop: { shop_id: @template_to_shop.shop_id, template_id: @template_to_shop.template_id }
    end

    assert_redirected_to template_to_shop_path(assigns(:template_to_shop))
  end

  test "should show template_to_shop" do
    get :show, id: @template_to_shop
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @template_to_shop
    assert_response :success
  end

  test "should update template_to_shop" do
    patch :update, id: @template_to_shop, template_to_shop: { shop_id: @template_to_shop.shop_id, template_id: @template_to_shop.template_id }
    assert_redirected_to template_to_shop_path(assigns(:template_to_shop))
  end

  test "should destroy template_to_shop" do
    assert_difference('TemplateToShop.count', -1) do
      delete :destroy, id: @template_to_shop
    end

    assert_redirected_to template_to_shops_path
  end
end
