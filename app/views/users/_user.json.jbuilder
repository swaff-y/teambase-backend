json.extract! user, :id, :email, :department, :name
json.url user_url(user, format: :json)
