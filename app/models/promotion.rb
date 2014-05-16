class Promotion < ActiveRecord::Base
  establish_connection :haonzhao
  attr_accessible :failed_at, :name,:htmll, :status
  attr_accessor :htmll
  
  has_many :certificates
  has_many :coupon_certificates, -> {where foo_type: 'Coupon'}, class_name: 'Certificate'
  has_many :coupons, through: :coupon_certificates, source: :foo, source_type: 'Coupon'
  has_many :products, through: :coupons
  has_many :voucher_certificates, -> {where foo_type: 'Voucher'}, class_name: 'Certificate'
  has_many :vouchers, through: :voucher_certificates, source: :foo, source_type: 'Voucher'

  before_update :save_html

  def save_html
  	self.html = self.htmll.original_filename
  end

end
