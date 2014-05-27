json.array!(@products) do |product|
  json.extract! product, :id, :model, :sku, :upc, :ean, :jan, :isbn, :mpn, :location, :quantity, :stock_status_id, :image, :manufacturer_id, :shipping, :price, :points, :tax_class_id, :date_available, :weight, :weight_class_id, :length, :width, :height, :length_class_id, :subtract, :minimum, :sort_order, :status, :date_added, :date_modified, :viewed, :name, :description, :meta_description, :meta_keyword
  json.url product_url(product, format: :json)
end
