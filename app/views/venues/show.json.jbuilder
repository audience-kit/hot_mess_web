json.partial! 'shared/entity', entity: @venue

json.extract! @venue, :facebook_id, :name, :phone, :about, :description

if @venue.picture
  json.picture do
    json.extract! @venue.picture, :url, :width, :height, :is_silhouette
  end
end

if @venue.location
  json.location do
    json.extract! @venue.location, :city, :country, :state, :street, :zip, :latitude, :longitude
  end
end