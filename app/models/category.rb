class Category < ActiveRecord::Base
  establish_connection :haonzhao
  attr_accessible :image, :parent_id, :top, :column, :sort_order, :status, :date_added, :date_modified, :name, :description, :meta_description, :meta_keyword
  self.table_name = "oc_category"
  self.primary_key = "category_id"

  has_one :category_description, :foreign_key => "category_id", :class_name => "CategoryDescription"
  belongs_to :parent, class_name: self
  has_many :children, foreign_key: "parent_id", class_name: self
  has_one :custom_category

  has_many :category_groups
  has_many :categorynavgroups, through: :category_groups
  
  has_many :category_to_attributes
  has_many :attribute_groups, through: :category_to_attributes
  has_many :attribute_group_descriptions, through: :category_to_attributes
  
  attr_accessor :name, :description, :meta_description, :meta_keyword
  
  after_find :set_name
  
  before_update :set_category_description
  
  def set_name
    self.name = category_description.name
    self.description = category_description.description
    self.meta_description = category_description.meta_description
    self.meta_keyword = category_description.meta_keyword
  end
  
  def set_category_description
    self.category_description.update_attributes name: name, description: description, meta_description: meta_description, meta_keyword: meta_keyword
  end
  
  def initialize args={}
    super
    self.top = false
    self.column = 0
    self.status = true
    self.sort_order = 0
    self.date_added = Time.now
    self.date_modified = Time.now
    self.category_description = CategoryDescription.new(name: args[:name], description: args[:description], meta_description: args[:meta_description], meta_keyword: args[:meta_keyword])
  end
  
end
