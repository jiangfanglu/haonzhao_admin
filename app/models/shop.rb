class Shop < ActiveRecord::Base
  # attr_accessible :title, :body
  establish_connection :haonzhao
  validates :manufacturer_id, :identity_no, :name, :register_type, presence: true
  validates :manufacturer_id, uniqueness: true
  self.table_name = 'oc_manufacturer'
  
  has_many :transactions, foreign_key: "store_id"


  def close
    update_attribute :status, 'Closed'
  end
  
  def close?
    status == 'Closed'
  end
  
  def allow
    update_attribute :status, 'Allowed'
  end
  
end
