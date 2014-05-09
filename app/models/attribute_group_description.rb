class AttributeGroupDescription < ActiveRecord::Base
  attr_accessible :name, :language_id
  establish_connection :haonzhao
  self.table_name = "oc_attribute_group_description"
  self.primary_key = 'attribute_group_id'
  default_scope :conditions => "language_id = ?"

  has_many :attributes, :primary_key=>"attribute_group_id", :foreign_key=>"attribute_group_id", :class_name => "Attribute"
  belongs_to :attribute_group, :primary_key=>"attribute_group_id", :foreign_key=>"attribute_group_id", :class_name => "AttributeGroup"

  has_many :category_to_attributes, :primary_key=>"attribute_group_id",:foreign_key=>"attribute_group_id"
  has_many :categories, through: :category_to_attributes
  has_many :category_descriptions, through: :category_to_attributes

  def initialize args={}
    super
    self.language_id = 3
    self.name = args[:name]
  end

end
