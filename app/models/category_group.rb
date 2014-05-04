class CategoryGroup < ActiveRecord::Base
	establish_connection :haonzhao
	attr_accessible   :category_id, :group_id
	self.table_name = "category_to_groups"

	belongs_to :categorynavgroup,:foreign_key=>"group_id",:primary_key=>"id", :class_name=>"Categorynavgroup"
     belongs_to :category
     belongs_to :category_description,:primary_key => "category_id", foreign_key: 'category_id', :class_name=>"CategoryDescription"
end
