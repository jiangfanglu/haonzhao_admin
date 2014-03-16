json.array!(@transactions) do |transaction|
  json.extract! transaction, :id, :transaction_source_type, :transaction_source_id, :account_type, :store_id, :comment, :sn, :money, :money_sign
  json.url transaction_url(transaction, format: :json)
end
