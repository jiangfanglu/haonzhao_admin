json.array!(@available_custom_categories) do |available_custom_category|
  json.extract! available_custom_category, :id, :category_id, :sort_order
  json.url available_custom_category_url(available_custom_category, format: :json)
end
