class Settlement < ActiveRecord::Base
  attr_accessible :comment, :title, :transactions, :money_sign, :money
  establish_connection :haonzhao
  
  has_many :transactions
  belongs_to :shop
  
  def complete?
    status == 'Complete'
  end
  
end
