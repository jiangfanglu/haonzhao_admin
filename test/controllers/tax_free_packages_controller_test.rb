require 'test_helper'

class TaxFreePackagesControllerTest < ActionController::TestCase
  setup do
    @tax_free_package = tax_free_packages(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tax_free_packages)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tax_free_package" do
    assert_difference('TaxFreePackage.count') do
      post :create, tax_free_package: { description: @tax_free_package.description, name: @tax_free_package.name, purchase_count: @tax_free_package.purchase_count, viewed: @tax_free_package.viewed }
    end

    assert_redirected_to tax_free_package_path(assigns(:tax_free_package))
  end

  test "should show tax_free_package" do
    get :show, id: @tax_free_package
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @tax_free_package
    assert_response :success
  end

  test "should update tax_free_package" do
    patch :update, id: @tax_free_package, tax_free_package: { description: @tax_free_package.description, name: @tax_free_package.name, purchase_count: @tax_free_package.purchase_count, viewed: @tax_free_package.viewed }
    assert_redirected_to tax_free_package_path(assigns(:tax_free_package))
  end

  test "should destroy tax_free_package" do
    assert_difference('TaxFreePackage.count', -1) do
      delete :destroy, id: @tax_free_package
    end

    assert_redirected_to tax_free_packages_path
  end
end
