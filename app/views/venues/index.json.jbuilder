json.array!(@venues) do |venue|
  json.extract! venue, :id, :facebook_id, :name, :phone, :about, :description
  json.url venue_url(venue, format: :json)
end
