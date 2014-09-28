json.array!(@events) do |event|
  json.partial! 'shared/entity', entity: event
  
  json.extract! event, :start, :end, :name
end
