class Product < ActiveRecord::Base
  establish_connection :haonzhao
  #approved 
  # 0 normal products
  # 1 applied products
  # 2 hangzhou approved products
  
  attr_accessible :model,:approved, :sku, :upc, :ean, :jan, :isbn, :mpn, :location, :quantity, :stock_status_id, :image, :manufacturer_id, :shipping, :price, :points, :tax_class_id, :date_available, :weight, :weight_class_id, :length, :width, :height, :length_class_id, :subtract, :minimum, :sort_order, :status, :date_added, :date_modified, :viewed
  self.table_name = :oc_product
  self.primary_key = :product_id
  
  has_one :product_description
  has_many :product_attributes
  has_many :product_categories
  has_many :product_images
  has_many :product_discounts
  has_many :categories, through: :productcategories

  has_many :fp_group_products

  belongs_to :shop,:foreign_key=>"manufacturer_id"

  has_many :order_products, :primary_key => "product_id", :foreign_key => "product_id"

  has_one :hz_product, :class_name=>"HzProduct"
  
  # attr_accessor :name, :description, :meta_description, :meta_keyword, :tag
  
  # before_update :save_description
  
  # after_find :set_description
  
  # def initialize args={}
  #   super
  #   self.product_description = ProductDescription.new args
  # end
  
  # def save_description
  #   product_description.update_attributes attributes.select{|key,v| [:name, :description, :meta_description, :meta_keyword, :tag].include? key }
  # end
  
  # def set_description
  #   self.name             = product_description.name
  #   self.description      = product_description.description
  #   self.meta_description = product_description.meta_description
  #   self.meta_keyword     = product_description.meta_keyword
  #   self.tag              = product_description.tag
  # end
  
end
