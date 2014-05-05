json.array!(@featured_shops) do |featured_shop|
  json.extract! featured_shop, :id, :manufacturer_id, :store_id
  json.url featured_shop_url(featured_shop, format: :json)
end
