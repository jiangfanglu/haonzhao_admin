class HzCompany < ActiveRecord::Base
	establish_connection :haonzhao
	attr_accessible :company_code, :org_code, :company_name, :company_type, :company_address, :registered_capital, :total_investment, :business_cope, :contact_person, :contact_info, :fax_no, :zipcode, :website_url, :email, :custom_code
end
