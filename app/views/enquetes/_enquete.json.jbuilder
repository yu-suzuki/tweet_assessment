json.extract! enquete, :id, :sex, :age, :place, :job, :machine, :user_id, :motivation, :created_at, :updated_at
json.url enquete_url(enquete, format: :json)