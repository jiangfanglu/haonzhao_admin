class OrderProduct < ActiveRecord::Base
	establish_connection :haonzhao
  
  	self.table_name = :oc_order_product
  	belongs_to :order
  	belongs_to :product, :primary_key => "product_id", :foreign_key => "product_id"
  	belongs_to :hz_product, :primary_key => "product_id", :foreign_key => "product_id", :class_name=>"HzProduct"
end
