json.array!(@coupons) do |coupon|
  json.extract! coupon, :id, :name, :type, :discount, :logged, :shipping, :total, :date_start, :date_end, :uses_total, :uses_customer, :integer, :status, :boolean, :date_added, :promotion_id
  json.url coupon_url(coupon, format: :json)
end
