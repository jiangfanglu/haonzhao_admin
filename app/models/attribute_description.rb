class AttributeDescription < ActiveRecord::Base
  attr_accessible :name, :language_id
  establish_connection :haonzhao
  self.table_name = "oc_attribute_description"
  default_scope :conditions => "language_id = 3"

  has_many :product_attributes, :foreign_key => "attribute_id",:primary_key=>"attribute_id", :class_name => "ProductAttribute"
  belongs_to :attribute, :primary_key=>"attribute_id", :foreign_key => "attribute_id", :class_name => "Attribute"
end