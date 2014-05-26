require 'test_helper'

class ShippingOptionsControllerTest < ActionController::TestCase
  setup do
    @shipping_option = shipping_options(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:shipping_options)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create shipping_option" do
    assert_difference('ShippingOption.count') do
      post :create, shipping_option: { option_value: @shipping_option.option_value, price: @shipping_option.price, shipping_id: @shipping_option.shipping_id }
    end

    assert_redirected_to shipping_option_path(assigns(:shipping_option))
  end

  test "should show shipping_option" do
    get :show, id: @shipping_option
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @shipping_option
    assert_response :success
  end

  test "should update shipping_option" do
    patch :update, id: @shipping_option, shipping_option: { option_value: @shipping_option.option_value, price: @shipping_option.price, shipping_id: @shipping_option.shipping_id }
    assert_redirected_to shipping_option_path(assigns(:shipping_option))
  end

  test "should destroy shipping_option" do
    assert_difference('ShippingOption.count', -1) do
      delete :destroy, id: @shipping_option
    end

    assert_redirected_to shipping_options_path
  end
end
