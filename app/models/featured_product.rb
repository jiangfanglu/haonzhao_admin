class FeaturedProduct < ActiveRecord::Base
	establish_connection :haonzhao
	attr_accessible :product_id, :store_id
	self.table_name = "oc_product_to_store"
	self.primary_key = "product_id"
end
