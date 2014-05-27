class ProductDescription < ActiveRecord::Base
  establish_connection :haonzhao
  attr_accessible :name, :description, :meta_description, :meta_keyword, :tag
  self.table_name = :oc_product_description
  self.primary_key = :product_id
  
  belongs_to :product
  
  def initialize args={}
    super
    self.name = args[:name]
    self.description = args[:description]
    self.meta_keyword = args[:meta_keyword]
    self.meta_description = args[:meta_description]
    self.tag = args[:tag]
  end
  
end
