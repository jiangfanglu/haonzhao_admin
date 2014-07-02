json.array!(@template_to_shops) do |template_to_shop|
  json.extract! template_to_shop, :id, :shop_id, :template_id
  json.url template_to_shop_url(template_to_shop, format: :json)
end
