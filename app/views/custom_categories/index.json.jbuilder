json.array!(@custom_categories) do |custom_category|
  json.extract! custom_category, :id, :category_id
  json.url custom_category_url(custom_category, format: :json)
end
