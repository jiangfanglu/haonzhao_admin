class SellerPayment < ActiveRecord::Base
  establish_connection :haonzhao
  attr_accessible :payment_account, :payment_type, :seller, :bank_name, :account_name, :verification, :fee_type
  
  belongs_to :seller, foreign_key: 'user_id', class_name: 'User'
end
