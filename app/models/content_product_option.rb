class ContentProductOption < ActiveRecord::Base
	establish_connection :haonzhao
	attr_accessible :product_id, :image,:alias
end
