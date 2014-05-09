class AttributeGroup < ActiveRecord::Base
  attr_accessible :sort_order
  establish_connection :haonzhao
  self.table_name = "oc_attribute_group"
  self.primary_key = 'attribute_group_id'
  has_many :attributes, :primary_key=>"attribute_group_id", :foreign_key => "attribute_group_id"
  has_many :attribute_descriptions, :primary_key=>"attribute_group_id", :foreign_key => "attribute_group_id", class_name: 'AttributeDescription'
  has_one :attribute_group_description, :primary_key=>"attribute_group_id", :foreign_key => "attribute_group_id"

  has_many :category_to_attributes
  has_many :categories, through: :category_to_attributes
  has_many :category_descriptions, through: :category_to_attributes
  
  attr_accessor :name
  
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
    self.attribute_group_description = AttributeGroupDescription.new(name: args[:name])
  end
  
end
