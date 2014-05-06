class Category < ActiveRecord::Base
  establish_connection :haonzhao
  self.table_name = "oc_category"

  has_one :category_description, :primary_key=>"category_id", :foreign_key => "category_id", :class_name => "CategoryDescription"

  has_many :category_groups
  has_many :categorynavgroups, through: :category_groups
end
