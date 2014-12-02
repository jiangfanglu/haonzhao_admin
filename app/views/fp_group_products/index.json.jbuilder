json.array!(@fp_group_products) do |fp_group_product|
  json.extract! fp_group_product, :id, :product_id, :group_id
  json.url fp_group_product_url(fp_group_product, format: :json)
end
