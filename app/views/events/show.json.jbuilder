json.partial! 'event', event: @event

if @event.picture
  json.picture do
    json.extract! @event.picture, :url, :width, :height, :is_silhouette
  end
end
