json.array!(@profiles) do |profile|
  json.extract! profile, :id, :name, :alias, :profile_type, :profile_group_id
  json.url profile_url(profile, format: :json)
end
