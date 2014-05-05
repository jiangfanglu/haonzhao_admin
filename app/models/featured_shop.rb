class FeaturedShop < ActiveRecord::Base
	establish_connection :haonzhao
	attr_accessible :manufacturer_id, :store_id
	self.table_name = "oc_manufacturer_to_store"
	self.primary_key = "manufacturer_id"
end
