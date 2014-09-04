json.array!(@events) do |event|
  json.extract! event, :id, :start, :end, :name
  json.url event_url(event, format: :json)
end
