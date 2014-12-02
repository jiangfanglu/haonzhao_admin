class Categorynavgroup < ActiveRecord::Base
  establish_connection :haonzhao
  self.table_name = "groups"

  has_many :category_groups, :foreign_key=> 'category_id', :primary_key=>"id"
  has_many :categories, through: :category_groups
  has_many :category_descriptions, through: :category_groups

  has_many :fp_group_products,:foreign_key=>"group_id",:primary_key=>"id"
end
