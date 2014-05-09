json.array!(@categories) do |category|
  json.extract! category, :id, :image, :parent_id, :top, :column, :sort_order, :status, :date_added, :date_modified, :name, :description, :meta_description, :meta_keyword
  json.url category_url(category, format: :json)
end
