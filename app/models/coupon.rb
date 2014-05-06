class Coupon < ActiveRecord::Base
  self.inheritance_column = :foo
  establish_connection :haonzhao
  attr_accessible :name, :type, :discount, :logged, :shipping, :total, :date_start, :date_end, :uses_total, :uses_customer, :status, :date_added, :promotion_id
  self.table_name = 'oc_coupon'
  self.primary_key = 'coupon_id'
  
  has_many :coupon_products
  has_many :products, through: :coupon_products
  has_many :certificates, -> { where foo_type: 'Coupon' }, foreign_key: :foo_id

  before_create :set_all_time
    
  def set_all_time
    self.date_added = Time.now
  end
  
end
