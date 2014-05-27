require 'test_helper'

class OrdersControllerTest < ActionController::TestCase
  setup do
    @order = orders(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:orders)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create order" do
    assert_difference('Order.count') do
      post :create, order: { accept_language: @order.accept_language, address_id: @order.address_id, affiliate_id: @order.affiliate_id, comment: @order.comment, commission: @order.commission, currency_code: @order.currency_code, currency_id: @order.currency_id, currency_value: @order.currency_value, customer_group_id: @order.customer_group_id, customer_id: @order.customer_id, date_added: @order.date_added, date_modified: @order.date_modified, email: @order.email, fax: @order.fax, firstname: @order.firstname, forwarded_ip: @order.forwarded_ip, invoice_no: @order.invoice_no, invoice_prefix: @order.invoice_prefix, ip: @order.ip, language_id: @order.language_id, lastname: @order.lastname, order_sn: @order.order_sn, order_status_id: @order.order_status_id, payment_address_1: @order.payment_address_1, payment_address_2: @order.payment_address_2, payment_address_format: @order.payment_address_format, payment_city: @order.payment_city, payment_code: @order.payment_code, payment_company: @order.payment_company, payment_company_id: @order.payment_company_id, payment_country: @order.payment_country, payment_country_id: @order.payment_country_id, payment_firstname: @order.payment_firstname, payment_lastname: @order.payment_lastname, payment_method: @order.payment_method, payment_postcode: @order.payment_postcode, payment_sn: @order.payment_sn, payment_tax_id: @order.payment_tax_id, payment_zone: @order.payment_zone, payment_zone_id: @order.payment_zone_id, shipping_address_1: @order.shipping_address_1, shipping_address_2: @order.shipping_address_2, shipping_address_format: @order.shipping_address_format, shipping_city: @order.shipping_city, shipping_code: @order.shipping_code, shipping_company: @order.shipping_company, shipping_country: @order.shipping_country, shipping_country_id: @order.shipping_country_id, shipping_firstname: @order.shipping_firstname, shipping_lastname: @order.shipping_lastname, shipping_method: @order.shipping_method, shipping_option_id: @order.shipping_option_id, shipping_postcode: @order.shipping_postcode, shipping_zone: @order.shipping_zone, shipping_zone_id: @order.shipping_zone_id, store_id: @order.store_id, store_name: @order.store_name, store_url: @order.store_url, telephone: @order.telephone, total: @order.total, user_agent: @order.user_agent }
    end

    assert_redirected_to order_path(assigns(:order))
  end

  test "should show order" do
    get :show, id: @order
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @order
    assert_response :success
  end

  test "should update order" do
    patch :update, id: @order, order: { accept_language: @order.accept_language, address_id: @order.address_id, affiliate_id: @order.affiliate_id, comment: @order.comment, commission: @order.commission, currency_code: @order.currency_code, currency_id: @order.currency_id, currency_value: @order.currency_value, customer_group_id: @order.customer_group_id, customer_id: @order.customer_id, date_added: @order.date_added, date_modified: @order.date_modified, email: @order.email, fax: @order.fax, firstname: @order.firstname, forwarded_ip: @order.forwarded_ip, invoice_no: @order.invoice_no, invoice_prefix: @order.invoice_prefix, ip: @order.ip, language_id: @order.language_id, lastname: @order.lastname, order_sn: @order.order_sn, order_status_id: @order.order_status_id, payment_address_1: @order.payment_address_1, payment_address_2: @order.payment_address_2, payment_address_format: @order.payment_address_format, payment_city: @order.payment_city, payment_code: @order.payment_code, payment_company: @order.payment_company, payment_company_id: @order.payment_company_id, payment_country: @order.payment_country, payment_country_id: @order.payment_country_id, payment_firstname: @order.payment_firstname, payment_lastname: @order.payment_lastname, payment_method: @order.payment_method, payment_postcode: @order.payment_postcode, payment_sn: @order.payment_sn, payment_tax_id: @order.payment_tax_id, payment_zone: @order.payment_zone, payment_zone_id: @order.payment_zone_id, shipping_address_1: @order.shipping_address_1, shipping_address_2: @order.shipping_address_2, shipping_address_format: @order.shipping_address_format, shipping_city: @order.shipping_city, shipping_code: @order.shipping_code, shipping_company: @order.shipping_company, shipping_country: @order.shipping_country, shipping_country_id: @order.shipping_country_id, shipping_firstname: @order.shipping_firstname, shipping_lastname: @order.shipping_lastname, shipping_method: @order.shipping_method, shipping_option_id: @order.shipping_option_id, shipping_postcode: @order.shipping_postcode, shipping_zone: @order.shipping_zone, shipping_zone_id: @order.shipping_zone_id, store_id: @order.store_id, store_name: @order.store_name, store_url: @order.store_url, telephone: @order.telephone, total: @order.total, user_agent: @order.user_agent }
    assert_redirected_to order_path(assigns(:order))
  end

  test "should destroy order" do
    assert_difference('Order.count', -1) do
      delete :destroy, id: @order
    end

    assert_redirected_to orders_path
  end
end
