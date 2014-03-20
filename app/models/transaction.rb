class Transaction < ActiveRecord::Base
  
  belongs_to :shop, foreign_key: 'store_id'
  
  def pay
    update_attribute :status, 'Paid'
  end
  
  def paid?
    status == 'Paid'
  end

  def unpay
    update_attribute :status, 'Unpaid'
  end

  
end
