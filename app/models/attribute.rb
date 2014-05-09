class Attribute < ActiveRecord::Base
  attr_accessible :attribute_group_id, :sort_order
  establish_connection :haonzhao
  self.table_name = "oc_attribute"
  self.primary_key = 'attribute_id'
  
  has_many :product_attributes, :foreign_key=>"attribute_id", :primary_key=>"attribute_id"
  has_one :attribute_description, :foreign_key => "attribute_id",:primary_key=>"attribute_id"
  belongs_to :attribute_group, :foreign_key => "attribute_group_id"
  belongs_to :attribute_group_description, :foreign_key => "attribute_group_id"
end
