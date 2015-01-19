require 'test_helper'

class ProductToTaxFreePackagesControllerTest < ActionController::TestCase
  setup do
    @product_to_tax_free_package = product_to_tax_free_packages(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:product_to_tax_free_packages)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create product_to_tax_free_package" do
    assert_difference('ProductToTaxFreePackage.count') do
      post :create, product_to_tax_free_package: { package_id: @product_to_tax_free_package.package_id, product_id: @product_to_tax_free_package.product_id }
    end

    assert_redirected_to product_to_tax_free_package_path(assigns(:product_to_tax_free_package))
  end

  test "should show product_to_tax_free_package" do
    get :show, id: @product_to_tax_free_package
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @product_to_tax_free_package
    assert_response :success
  end

  test "should update product_to_tax_free_package" do
    patch :update, id: @product_to_tax_free_package, product_to_tax_free_package: { package_id: @product_to_tax_free_package.package_id, product_id: @product_to_tax_free_package.product_id }
    assert_redirected_to product_to_tax_free_package_path(assigns(:product_to_tax_free_package))
  end

  test "should destroy product_to_tax_free_package" do
    assert_difference('ProductToTaxFreePackage.count', -1) do
      delete :destroy, id: @product_to_tax_free_package
    end

    assert_redirected_to product_to_tax_free_packages_path
  end
end
