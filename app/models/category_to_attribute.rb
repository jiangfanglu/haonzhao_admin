class CategoryToAttribute < ActiveRecord::Base
  attr_accessible :category_id, :category, :attribute_group
  establish_connection :haonzhao
  belongs_to :category
  belongs_to :category_description, :primary_key=>"category_id",:foreign_key=>"category_id"
  belongs_to :attribute_group
  belongs_to :attribute_group_description, :primary_key=>"attribute_group_id",:foreign_key=>"attribute_group_id"
end
