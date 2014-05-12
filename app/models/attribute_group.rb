class AttributeGroup < ActiveRecord::Base
  attr_accessible :sort_order, :name, :category_id
  establish_connection :haonzhao
  self.table_name = :oc_attribute_group
  self.primary_key = :attribute_group_id
  
  has_many :select_attributes, foreign_key: :attribute_group_id, class_name: 'Attribute'
  has_many :select_attribute_descriptions, foreign_key: :attribute_group_id, class_name: 'AttributeDescription'
  has_one :attribute_group_description, foreign_key: :attribute_group_id
  has_many :category_to_attributes
  has_many :categories, through: :category_to_attributes
  has_many :category_descriptions, through: :category_to_attributes
  
  attr_accessor :name, :category_id
  
  after_find :set_name
  
  before_update :set_attribute_group_description
  
  def set_name
    self.name = attribute_group_description.name
  end
  
  def set_attribute_group_description
    self.attribute_group_description.update_attributes name: name
  end
  
  def initialize args={}
    super
    self.name = args[:name]
    self.attribute_group_description = AttributeGroupDescription.new(name: args[:name])
  end
  
end
