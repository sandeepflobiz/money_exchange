json.extract! user, :id, :name, :mobile, :password, :status, :created_at, :updated_at
json.url user_url(user, format: :json)
