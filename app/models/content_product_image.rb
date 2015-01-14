class ContentProductImage < ActiveRecord::Base
	establish_connection :haonzhao
	attr_accessible :image, :sort_order
	belongs_to :content_product
end
