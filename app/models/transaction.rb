class Transaction < ActiveRecord::Base
  establish_connection :haonzhao
    
  belongs_to :settlement
  belongs_to :sender, polymorphic: true 
  belongs_to :receiver, polymorphic: true 
    
  scope :paid_by_shop, ->(user_id) {where("(receiver_id = ? AND receiver_type = 'User' AND status = 'Paid') OR (sender_id = ? AND sender_type = 'Shop' AND status = 'Paid')", user_id, user_id)}

  scope :unpaid_by_shop, ->(user_id) {where("(receiver_id = ? AND receiver_type = 'User' AND status = 'Unpaid') OR (sender_id = ? AND sender_type = 'Shop' AND status = 'Unpaid')", user_id, user_id)}
  
  scope :all_by_shop, ->(store_id) {where("(receiver_id = ? AND receiver_type = 'User') OR (sender_id = ? AND sender_type = 'Shop')", store_id, store_id)}
  
  def pay
    update_attribute :status, 'Paid'
  end

  def unpay
    update_attribute :status, 'Unpaid'
  end
  
  def complete
    update_attribute :status, 'Complete' if paid?
  end
  
  def fee?
    transaction_source_type == 'Fee'
  end
  
  def order?
    transaction_source_type == 'Order'
  end
  
  def paid?
    status == 'Paid'
  end

  def complete?
    status == 'Complete'
  end

  
end
