json.extract! user, :id, :email, :name,:address,:postal_code, :birthdate, :created_at, :updated_at
json.url user_url(user, format: :json)
