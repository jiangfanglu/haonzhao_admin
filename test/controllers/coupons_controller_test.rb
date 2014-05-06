require 'test_helper'

class CouponsControllerTest < ActionController::TestCase
  setup do
    @coupon = coupons(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:coupons)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create coupon" do
    assert_difference('Coupon.count') do
      post :create, coupon: { boolean: @coupon.boolean, date_added: @coupon.date_added, date_end: @coupon.date_end, date_start: @coupon.date_start, discount: @coupon.discount, integer: @coupon.integer, logged: @coupon.logged, name: @coupon.name, promotion_id: @coupon.promotion_id, shipping: @coupon.shipping, status: @coupon.status, total: @coupon.total, type: @coupon.type, uses_customer: @coupon.uses_customer, uses_total: @coupon.uses_total }
    end

    assert_redirected_to coupon_path(assigns(:coupon))
  end

  test "should show coupon" do
    get :show, id: @coupon
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @coupon
    assert_response :success
  end

  test "should update coupon" do
    patch :update, id: @coupon, coupon: { boolean: @coupon.boolean, date_added: @coupon.date_added, date_end: @coupon.date_end, date_start: @coupon.date_start, discount: @coupon.discount, integer: @coupon.integer, logged: @coupon.logged, name: @coupon.name, promotion_id: @coupon.promotion_id, shipping: @coupon.shipping, status: @coupon.status, total: @coupon.total, type: @coupon.type, uses_customer: @coupon.uses_customer, uses_total: @coupon.uses_total }
    assert_redirected_to coupon_path(assigns(:coupon))
  end

  test "should destroy coupon" do
    assert_difference('Coupon.count', -1) do
      delete :destroy, id: @coupon
    end

    assert_redirected_to coupons_path
  end
end
