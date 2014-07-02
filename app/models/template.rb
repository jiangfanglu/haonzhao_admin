class Template < ActiveRecord::Base
	establish_connection :haonzhao
  	self.table_name = 'templates'
  	attr_accessible :rating, :title, :code, :price, :used, :params, :template_category_id, :author_id, :tags
end
