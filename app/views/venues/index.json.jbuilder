json.array!(@venues) do |venue|
  json.id venue.id.to_s
  json.extract! venue, :facebook_id, :name, :phone, :about, :description

  if venue.picture
    json.picture_url venue.picture.url
  end

  json.url venue_url(venue, format: :json)
end
