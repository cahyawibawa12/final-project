json.extract! order, :id, :customer_email, :total, :created_at, :updated_at
json.url order_url(order, format: :json)