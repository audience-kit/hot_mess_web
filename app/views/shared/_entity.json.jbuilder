json.id entity.id.to_s
json.url polymorphic_path(entity, format: :json)
json.extract! entity, :created_at, :updated_at