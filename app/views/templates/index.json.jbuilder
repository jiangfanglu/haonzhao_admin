json.array!(@templates) do |template|
  json.extract! template, :id, :rating, :title, :code, :price, :used, :params, :template_category_id, :author_id, :tags
  json.url template_url(template, format: :json)
end
