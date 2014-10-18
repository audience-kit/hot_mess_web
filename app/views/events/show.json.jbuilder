json.partial! 'shared/entity', entity: @event

json.extract! @event, :start_time, :end_time, :name, :description

if @event.picture
  json.picture do
    json.extract! @event.picture, :url, :width, :height, :is_silhouette
  end
end
