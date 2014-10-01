class HzProduct < ActiveRecord::Base
	establish_connection :haonzhao
	belongs_to :product
 	belongs_to :hz_post_tax, :primary_key=>"post_tax_no",:foreign_key=>"post_tax_no", :class_name=>"HzPostTax"
end
