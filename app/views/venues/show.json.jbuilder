json.partial! 'shared/entity', entity: @venue

json.extract! @venue, :facebook_id, :name, :phone, :about, :description
json.pictures @venue.pictures, :url, :width, :height, :is_silhouette
json.location @venue.location, :city, :country, :state, :street, :zip, :latitude, :longitude
