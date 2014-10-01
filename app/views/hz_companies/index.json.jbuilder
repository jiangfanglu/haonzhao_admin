json.array!(@hz_companies) do |hz_company|
  json.extract! hz_company, :id, :company_code, :org_code, :company_name, :company_type, :company_address, :registered_capital, :total_investment, :business_cope, :contact_person, :contact_info, :fax_no, :zipcode, :website_url, :email, :custom_code
  json.url hz_company_url(hz_company, format: :json)
end
