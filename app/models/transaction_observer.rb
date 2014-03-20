class TransactionObserver < ActiveRecord::Observer
  
  def after_update transaction
    transaction.paid? ? activate_fees_for(transaction) : unactivate_fees_for(transaction) unless transaction.fee?
  end
  
  
  
  private
  def unactivate_fees_for transaction
    Transaction.update_all("status = 'Activated'",transaction_source_type: 'Fee', transaction_source_id: transaction.transaction_source_id, store_id: transaction.store_id)
  end
  
  def activate_fees_for transaction
    Transaction.update_all("status = 'Unactivated'",transaction_source_type: 'Fee', transaction_source_id: transaction.transaction_source_id, store_id: transaction.store_id)
  end
  
end
