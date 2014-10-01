class HzPostTax < ActiveRecord::Base
	establish_connection :haonzhao
	has_many :hz_products, :primary_key=>"post_tax_no",:foreign_key=>"post_tax_no"
end
