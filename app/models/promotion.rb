class Promotion < ActiveRecord::Base
  establish_connection :haonzhao
  attr_accessible :failed_at, :name, :status
  
  has_many :certificates
  has_many :coupons, through: :certificates
  has_many :products, through: :coupons
  has_many :vouchers, through: :certificates

end
