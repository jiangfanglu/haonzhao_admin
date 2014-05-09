class CategoryDescription < ActiveRecord::Base
  establish_connection :haonzhao
  attr_accessible :name, :description, :meta_description, :meta_keyword
  self.table_name = "oc_category_description"
  self.primary_key = "category_id"

  belongs_to :category, foreign_key: "category_id", class_name: "Category"
	
  has_many :category_groups, foreign_key: 'category_id'
  has_many :categorynavgroups, through: :category_groups
  
  def initialize args={}
    super
    self.language_id = 3
    self.name = args[:name]
    self.description = args[:description]
    self.meta_description = args[:meta_description]
    self.meta_keyword = args[:meta_keyword]
  end

end
