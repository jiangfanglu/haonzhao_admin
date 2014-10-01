require 'test_helper'

class HzCompaniesControllerTest < ActionController::TestCase
  setup do
    @hz_company = hz_companies(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:hz_companies)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create hz_company" do
    assert_difference('HzCompany.count') do
      post :create, hz_company: { business_cope: @hz_company.business_cope, company_address: @hz_company.company_address, company_code: @hz_company.company_code, company_name: @hz_company.company_name, company_type: @hz_company.company_type, contact_info: @hz_company.contact_info, contact_person: @hz_company.contact_person, custom_code: @hz_company.custom_code, email: @hz_company.email, fax_no: @hz_company.fax_no, org_code: @hz_company.org_code, registered_capital: @hz_company.registered_capital, total_investment: @hz_company.total_investment, website_url: @hz_company.website_url, zipcode: @hz_company.zipcode }
    end

    assert_redirected_to hz_company_path(assigns(:hz_company))
  end

  test "should show hz_company" do
    get :show, id: @hz_company
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @hz_company
    assert_response :success
  end

  test "should update hz_company" do
    patch :update, id: @hz_company, hz_company: { business_cope: @hz_company.business_cope, company_address: @hz_company.company_address, company_code: @hz_company.company_code, company_name: @hz_company.company_name, company_type: @hz_company.company_type, contact_info: @hz_company.contact_info, contact_person: @hz_company.contact_person, custom_code: @hz_company.custom_code, email: @hz_company.email, fax_no: @hz_company.fax_no, org_code: @hz_company.org_code, registered_capital: @hz_company.registered_capital, total_investment: @hz_company.total_investment, website_url: @hz_company.website_url, zipcode: @hz_company.zipcode }
    assert_redirected_to hz_company_path(assigns(:hz_company))
  end

  test "should destroy hz_company" do
    assert_difference('HzCompany.count', -1) do
      delete :destroy, id: @hz_company
    end

    assert_redirected_to hz_companies_path
  end
end
