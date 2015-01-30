class ContentProduct < ActiveRecord::Base
	establish_connection :haonzhao
	attr_accessible :product_id, :title, :meta_description, :country_code, :video, :tags, :alias, :max_price, :min_price,:package_id
	has_many :content_product_images
end
