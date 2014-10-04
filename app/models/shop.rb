class Shop < ActiveRecord::Base
  # attr_accessible :title, :body
  establish_connection :haonzhao
  validates :manufacturer_id, :identity_no, :name, :register_type, presence: true
  validates :manufacturer_id, uniqueness: true
  self.table_name = :oc_manufacturer
  self.primary_key = :manufacturer_id
  alias :manufacturer_id :id
  
  belongs_to :user, foreign_key: :id
  has_many :transactions, foreign_key: :store_id
  has_many :settlements
  has_many :orders, :primary_key=>"manufacturer_id", :foreign_key=>"store_id"
  has_many :products, :foreign_key=>"manufacturer_id"

  has_one :hz_manufacturer, :primary_key=>"manufacturer_id", :foreign_key=>"manufacturer_id", :class_name=>"HzManufacturer"

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
