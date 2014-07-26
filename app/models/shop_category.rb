class ShopCategory < ActiveRecord::Base
	establish_connection :haonzhao
	attr_accessible :user_id,:category_id
	self.table_name = 'shop_categories'

	def save_info(user_id,category_id)
	  	self.user_id = user_id
	  	self.category_id = category_id
	end
end
