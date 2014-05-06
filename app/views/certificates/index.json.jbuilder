json.array!(@certificates) do |certificate|
  json.extract! certificate, :id, :code, :foo_type, :foo_id, :customer_id
  json.url certificate_url(certificate, format: :json)
end
