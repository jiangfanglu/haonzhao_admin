class Attribute < ActiveRecord::Base
  attr_accessible :attribute_group_id, :sort_order, :name
  establish_connection :haonzhao
  self.table_name = "oc_attribute"
  self.primary_key = 'attribute_id'
  
  has_many :product_attributes, :foreign_key=>"attribute_id", :primary_key=>"attribute_id"
  has_one :attribute_description, :foreign_key => "attribute_id",:primary_key=>"attribute_id"
  belongs_to :attribute_group, :foreign_key => "attribute_group_id"
  belongs_to :attribute_group_description, :foreign_key => "attribute_group_id"
  
  attr_accessor :name
  
  after_find :set_name
  
  after_update :update_name
  
  def set_name
    self.name = self.attribute_description.name
  end
  
  def update_name
    self.attribute_description.update_attribute :name, self.name
  end
    
  def initialize args={}
    super
    self.sort_order = 0
    self.attribute_description = AttributeDescription.new(name: args[:name])
  end
  
end
