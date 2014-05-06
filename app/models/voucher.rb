class Voucher < ActiveRecord::Base
  establish_connection :haonzhao
  attr_accessible :order_id, :from_name, :from_email, :to_name, :to_email, :voucher_theme_id, :message, :amount, :status
  self.table_name = 'oc_voucher'
  self.primary_key = 'voucher_id'
  
  has_many :certificates, -> { where foo_type: 'Voucher' }, foreign_key: :foo_id
  
  def name
    from_name + '赠送给' + to_name + '的礼金券'
  end
  
  def value
    '￥' + amount.to_s
  end
  
end
