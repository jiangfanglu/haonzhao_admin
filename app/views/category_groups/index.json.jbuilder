json.array!(@category_groups) do |category_group|
  json.extract! category_group, :id, :category_id, :group_id
  json.url category_group_url(category_group, format: :json)
end
