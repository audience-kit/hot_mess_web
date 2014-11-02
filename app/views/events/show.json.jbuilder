json.partial! 'event', event: @event

if @event.picture
  json.picture do
    json.extract! @event.picture, :url, :width, :height, :is_silhouette
  end
end

if @event.venue
  json.venue do
    json.partial! 'venues/venue', venue: @event.venue
  end
end
