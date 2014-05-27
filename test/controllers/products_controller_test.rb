require 'test_helper'

class ProductsControllerTest < ActionController::TestCase
  setup do
    @product = products(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:products)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create product" do
    assert_difference('Product.count') do
      post :create, product: { date_added: @product.date_added, date_available: @product.date_available, date_modified: @product.date_modified, description: @product.description, ean: @product.ean, height: @product.height, image: @product.image, isbn: @product.isbn, jan: @product.jan, length: @product.length, length_class_id: @product.length_class_id, location: @product.location, manufacturer_id: @product.manufacturer_id, meta_description: @product.meta_description, meta_keyword: @product.meta_keyword, minimum: @product.minimum, model: @product.model, mpn: @product.mpn, name: @product.name, points: @product.points, price: @product.price, quantity: @product.quantity, shipping: @product.shipping, sku: @product.sku, sort_order: @product.sort_order, status: @product.status, stock_status_id: @product.stock_status_id, subtract: @product.subtract, tax_class_id: @product.tax_class_id, upc: @product.upc, viewed: @product.viewed, weight: @product.weight, weight_class_id: @product.weight_class_id, width: @product.width }
    end

    assert_redirected_to product_path(assigns(:product))
  end

  test "should show product" do
    get :show, id: @product
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @product
    assert_response :success
  end

  test "should update product" do
    patch :update, id: @product, product: { date_added: @product.date_added, date_available: @product.date_available, date_modified: @product.date_modified, description: @product.description, ean: @product.ean, height: @product.height, image: @product.image, isbn: @product.isbn, jan: @product.jan, length: @product.length, length_class_id: @product.length_class_id, location: @product.location, manufacturer_id: @product.manufacturer_id, meta_description: @product.meta_description, meta_keyword: @product.meta_keyword, minimum: @product.minimum, model: @product.model, mpn: @product.mpn, name: @product.name, points: @product.points, price: @product.price, quantity: @product.quantity, shipping: @product.shipping, sku: @product.sku, sort_order: @product.sort_order, status: @product.status, stock_status_id: @product.stock_status_id, subtract: @product.subtract, tax_class_id: @product.tax_class_id, upc: @product.upc, viewed: @product.viewed, weight: @product.weight, weight_class_id: @product.weight_class_id, width: @product.width }
    assert_redirected_to product_path(assigns(:product))
  end

  test "should destroy product" do
    assert_difference('Product.count', -1) do
      delete :destroy, id: @product
    end

    assert_redirected_to products_path
  end
end
