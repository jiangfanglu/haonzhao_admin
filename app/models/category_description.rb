class CategoryDescription < ActiveRecord::Base
  establish_connection :haonzhao
  self.table_name = "oc_category_description"

  belongs_to :category, :primary_key=>"category_id", foreign_key: "category_id", class_name: "Category"
	
  has_many :category_groups, :primary_key => "category_id", foreign_key: 'category_id'
  has_many :categorynavgroups, through: :category_groups
end
