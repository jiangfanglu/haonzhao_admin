json.array!(@template_categories) do |template_category|
  json.extract! template_category, :id, :name, :sort_order
  json.url template_category_url(template_category, format: :json)
end
