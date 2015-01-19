json.array!(@product_to_tax_free_packages) do |product_to_tax_free_package|
  json.extract! product_to_tax_free_package, :id, :package_id, :product_id
  json.url product_to_tax_free_package_url(product_to_tax_free_package, format: :json)
end
