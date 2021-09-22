json.extract! post, :id, :msg, :user_id, :date, :created_at, :updated_at
json.url post_url(post, format: :json)
