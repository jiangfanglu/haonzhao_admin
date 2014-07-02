class TemplateToShop < ActiveRecord::Base
	establish_connection :haonzhao
  	self.table_name = 'template_to_shops'
  	attr_accessible :shop_id, :template_id
end
