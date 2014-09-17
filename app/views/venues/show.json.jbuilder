json.id @venue.id.to_s
json.extract! @venue, :name, :address, :phone, :created_at, :updated_at

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