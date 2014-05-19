json.array!(@profile_values) do |profile_value|
  json.extract! profile_value, :id, :name, :alias, :profile_id
  json.url profile_value_url(profile_value, format: :json)
end
