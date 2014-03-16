class Shop < ActiveRecord::Base
  # attr_accessible :title, :body
  validates :manufacturer_id, :identity_no, :name, :register_type, presence: true
  validates :manufacturer_id, uniqueness: true
  self.table_name = 'oc_manufacturer'
  
  has_many :transactions, foreign_key: "store_id"

  
end
