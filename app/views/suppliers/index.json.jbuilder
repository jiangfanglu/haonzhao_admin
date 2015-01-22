json.array!(@suppliers) do |supplier|
  json.extract! supplier, :id, :name, :identification, :address, :country_code, :contact, :contact_no, :email, :website, :wechat, :qq, :grade
  json.url supplier_url(supplier, format: :json)
end
