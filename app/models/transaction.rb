class Transaction < ActiveRecord::Base
    
  belongs_to :sender, :polymorphic => true 
  belongs_to :receiver, :polymorphic => true 
  
  scope :by_user, lambda {|user_id|{
    conditions: ["(receiver_id = ? AND receiver_type = 'User') OR (sender_id = ? AND sender_type = 'User')", user_id, user_id]
  }}
  
  scope :paid_with_shop, lambda{|user_id|{
    conditions: ["(receiver_id = ? AND receiver_type = 'User' AND status = 'Paid') OR (sender_id = ? AND sender_type = 'User' AND status = 'Paid')", user_id, user_id]
  }}

  scope :unpaid_with_shop, lambda{|user_id|{
    conditions: ["(receiver_id = ? AND receiver_type = 'User' AND status = 'Unpaid') OR (sender_id = ? AND sender_type = 'User' AND status = 'Unpaid')", user_id, user_id]
  }}
  
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
