json.array!(@shops) do |shop|
  json.extract! shop, :id, :name, :image, :identity_no, :business_rego_no, :business_name, :organization_no, :register_type, :shipping_option_id
  json.url shop_url(shop, format: :json)
end
