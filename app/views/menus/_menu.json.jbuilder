json.extract! menu, :id, :name, :description, :price, :category_id, :created_at, :updated_at
json.url menu_url(menu, format: :json)