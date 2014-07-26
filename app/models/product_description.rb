class ProductDescription < ActiveRecord::Base
  establish_connection :haonzhao
  attr_accessible :name, :description, :meta_description, :meta_keyword, :tag
  self.table_name = :oc_product_description
  self.primary_key = :product_id
  default_scope conditions: "language_id = 3"
  
  belongs_to :product
  
  # def initialize args={}
  #   super
  #   self.name = args[:name]
  #   self.description = args[:description]
  #   self.meta_keyword = args[:meta_keyword]
  #   self.meta_description = args[:meta_description]
  #   self.tag = args[:tag]
  # end

  def save_info(product_id, name,description,meta_description,meta_keyword,tag)
    self.product_id = product_id
    self.name = name
    self.description = description
    self.meta_keyword = meta_keyword
    self.language_id = 3
    self.meta_description = meta_description
    self.tag = tag
  end
  
end
