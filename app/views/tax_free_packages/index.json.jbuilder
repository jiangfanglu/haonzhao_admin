json.array!(@tax_free_packages) do |tax_free_package|
  json.extract! tax_free_package, :id, :name, :description, :purchase_count, :viewed
  json.url tax_free_package_url(tax_free_package, format: :json)
end
