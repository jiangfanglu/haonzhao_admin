json.array!(@shippings) do |shipping|
  json.extract! shipping, :id, :name, :code
  json.url shipping_url(shipping, format: :json)
end
