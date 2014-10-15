json.array!(@events) do |event|
  json.partial! 'shared/entity', entity: event
  
  json.extract! event, :start_time, :end_time, :name, :description
end
