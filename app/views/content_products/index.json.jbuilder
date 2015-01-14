json.array!(@content_products) do |content_product|
  json.extract! content_product, :id, :product_id, :title, :meta_description, :country_code, :video, :tags
  json.url content_product_url(content_product, format: :json)
end
