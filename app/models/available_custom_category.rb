class AvailableCustomCategory < ActiveRecord::Base
	establish_connection :haonzhao
	attr_accessible   :category_id, :sort_order
    self.table_name = "available_categories"
end
