json.array!(@promotions) do |promotion|
  json.extract! promotion, :id, :name, :failed_at
  json.url promotion_url(promotion, format: :json)
end
