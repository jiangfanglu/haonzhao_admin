class CategoryToAttribute < ActiveRecord::Base
  attr_accessible :category_id, :category, :attribute_group
  establish_connection :haonzhao
  self.primary_key = :category_id
  belongs_to :category
  belongs_to :category_description, foreign_key: :category_id
  belongs_to :attribute_group
  belongs_to :attribute_group_description, foreign_key: :attribute_group_id
end
