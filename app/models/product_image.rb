class ProductImage < ActiveRecord::Base
	establish_connection :haonzhao
    attr_accessible :product_id,:image,:sort_order
    self.table_name = :oc_product_image
    self.primary_key = :product_image_id
	
    belongs_to :product

	def save_info(product_id,image,sort_order) 
		self.product_id = product_id
		self.image = image
		self.sort_order = sort_order
	end
end
