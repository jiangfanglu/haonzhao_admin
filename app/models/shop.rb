class Shop < ActiveRecord::Base
  # attr_accessible :title, :body
  establish_connection :haonzhao
  validates :manufacturer_id, :identity_no, :name, :register_type, presence: true
  validates :manufacturer_id, uniqueness: true
  self.table_name = 'oc_manufacturer'
  alias :manufacturer_id :id
  
  has_many :transactions, foreign_key: "store_id"
  has_many :settlements
  
  scope :transact, -> { joins('INNER JOIN (transactions) ON (transactions.receiver_id = oc_manufacturer.manufacturer_id AND transactions.transaction_source_type = "Order")').where('transactions.status = "Paid" AND transactions.receiver_type = "User"').order('transactions.created_at DESC').group('oc_manufacturer.manufacturer_id') } 

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
