# require 'code_lib'
class Voucher < ActiveRecord::Base
  establish_connection :haonzhao
  attr_accessible :order_id, :from_name, :from_email, :to_name, :to_email, :voucher_theme_id, :message, :amount, :status
  self.table_name = 'oc_voucher'
  self.primary_key = 'voucher_id'
  # KEY = '985318588251l727'
  
  has_many :certificates, -> { where foo_type: 'Voucher' }, foreign_key: :foo_id
  
  # class << self
  #   include CodeLib
  # end
  # 
  # def initialize args = {}
  #   super
  #   self.set_code
  # end
  # 
  # def set_code
  #   self.code = Coupon.create_code SecureRandom.hex(6)
  # end
    
  
end
