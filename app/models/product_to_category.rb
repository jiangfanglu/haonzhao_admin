class ProductToCategory < ActiveRecord::Base
	attr_accessible :product_id, :category_id
  	establish_connection :haonzhao
  	self.table_name = :oc_product_to_category
  	def save_info(product_id,category_id)
  		self.product_id = product_id
  		self.category_id = category_id
  	end
end
