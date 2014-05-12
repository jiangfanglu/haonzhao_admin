class AttributeDescription < ActiveRecord::Base
  attr_accessible :name, :language_id
  establish_connection :haonzhao
  self.table_name = :oc_attribute_description
  self.primary_key = :attribute_id
  # default_scope :conditions => "language_id = 3"

  has_many :product_attributes, foreign_key: :attribute_id, class_name: "ProductAttribute"
  belongs_to :select_attribute, foreign_key: :attribute_id, class_name: "Attribute"
  
  def initialize args={}
    super
    self.language_id = 3
  end
  
end