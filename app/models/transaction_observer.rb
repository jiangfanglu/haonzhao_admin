class TransactionObserver < ActiveRecord::Observer
  
  def after_update transaction
    if transaction.order?
      case transaction.transaction_source_type
      when 'Paid'
        activate_fees_for(transaction)
      when 'Unpaid'
        unactivate_fees_for(transaction)
      end
    end
  end
  
  private
  def unactivate_fees_for transaction
    Transaction.where(transaction_source_type: 'Fee', transaction_source_id: transaction.transaction_source_id, receiver_type: 'hnz').each{|fee|fee.unpay}
  end
  
  def activate_fees_for transaction
    Transaction.where(transaction_source_type: 'Fee', transaction_source_id: transaction.transaction_source_id, receiver_type: 'hnz').each{|fee|fee.pay}
  end
  
end
