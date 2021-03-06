class ProductAttribute < ActiveRecord::Base
  attr_accessible :product_id, :attribute_id, :language_id, :text
  establish_connection :haonzhao
  self.table_name = :oc_product_attribute
  self.primary_key = :product_id
  default_scope conditions: "language_id = 3"

  belongs_to :product
  belongs_to :attribute
  belongs_to :attribute_description, foreign_key: :attribute_id

  def save_info(product_id,attribute_id,text)
  	self.product_id = product_id
  	self.attribute_id = attribute_id
  self.language_id = 3
  	self.text = text
  end
end
