json.partial! 'venue', venue: @venue

json.pictures @venue.pictures, :url, :width, :height, :is_silhouette
json.location @venue.location, :city, :country, :state, :street, :zip, :latitude, :longitude

json.events do
  json.array! @venue.events do |event|
    json.partial! 'events/event', event: event
  end
end