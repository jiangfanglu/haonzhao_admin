json.array!(@vouchers) do |voucher|
  json.extract! voucher, :id, :order_id, :code, :from_name, :from_email, :to_name, :to_email, :voucher_theme_id, :message, :amount, :status, :date_added
  json.url voucher_url(voucher, format: :json)
end
