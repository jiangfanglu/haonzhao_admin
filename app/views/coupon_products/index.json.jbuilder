json.array!(@coupon_products) do |coupon_product|
  json.extract! coupon_product, :id, :coupon_id, :product_id
  json.url coupon_product_url(coupon_product, format: :json)
end
