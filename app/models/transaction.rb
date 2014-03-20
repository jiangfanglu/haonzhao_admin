class Transaction < ActiveRecord::Base
  attr_accessible :account_type, :transaction_source_id, :transaction_source_type, :comment, :money, :money_sign, :status, :sn, :sender, :receiver
    
  belongs_to :sender, :polymorphic => true 
  belongs_to :receiver, :polymorphic => true 
  
  
  def pay
    update_attribute :status, 'Paid'
  end
  
  def fee?
    transaction_source_type == 'Fee'
  end
  
  def paid?
    status == 'Paid'
  end

  def unpay
    update_attribute :status, 'Unpaid'
  end

  
end
