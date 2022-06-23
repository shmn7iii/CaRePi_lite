json.extract! user, :id, :student_number, :name, :entry, :created_at, :updated_at
json.url user_url(user, format: :json)
