class HzProduct < ActiveRecord::Base
	establish_connection :haonzhao
	attr_accessible :approve_result,:approve_comment,:process_time, :barcode, :post_tax_no, :material_address, :unit_code, :hz_purpose_code, :standard, :main_elements, :product_id
	belongs_to :product
	has_many :order_products, :primary_key => "product_id", :foreign_key => "product_id"
 	belongs_to :hz_post_tax, :primary_key=>"post_tax_no",:foreign_key=>"post_tax_no", :class_name=>"HzPostTax"
 	belongs_to :hz_company, :foreign_key=>"hz_company_id"
end
