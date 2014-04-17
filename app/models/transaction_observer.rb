class TransactionObserver < ActiveRecord::Observer
  
  def after_update transaction
    transaction.paid? ? activate_fees_for(transaction) : unactivate_fees_for(transaction) if transaction.order?
  end
  
  private
  def unactivate_fees_for transaction
    Transaction.where(transaction_source_type: 'Fee', transaction_source_id: transaction.transaction_source_id, receiver_type: 'hnz').each{|fee|fee.unpay}
  end
  
  def activate_fees_for transaction
    Transaction.where(transaction_source_type: 'Fee', transaction_source_id: transaction.transaction_source_id, receiver_type: 'hnz').each{|fee|fee.pay}
  end
  
end
