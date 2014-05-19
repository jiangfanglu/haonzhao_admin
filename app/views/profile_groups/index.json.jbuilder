json.array!(@profile_groups) do |profile_group|
  json.extract! profile_group, :id, :name, :alias
  json.url profile_group_url(profile_group, format: :json)
end
