class Promotion < ActiveRecord::Base
  establish_connection :haonzhao
  attr_accessible :failed_at, :name, :status
  
  has_many :certificates
  has_many :coupon_certificates, -> {where foo_type: 'Coupon'}, class_name: 'Certificate'
  has_many :coupons, through: :certificates
  has_many :products, through: :coupons
  has_many :voucher_certificates, -> {where foo_type: 'Voucher'}, class_name: 'Certificate'
  has_many :vouchers, through: :certificates

end
