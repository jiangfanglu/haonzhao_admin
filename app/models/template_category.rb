class TemplateCategory < ActiveRecord::Base
	establish_connection :haonzhao
  	self.table_name = 'template_categories'
  	attr_accessible :name, :sort_order
end
