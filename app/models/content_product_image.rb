class ContentProductImage < ActiveRecord::Base
	establish_connection :haonzhao
	attr_accessible :image, :sort_order,:content_product_id
	belongs_to :content_product
end
