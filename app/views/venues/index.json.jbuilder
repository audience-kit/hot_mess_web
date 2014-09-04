json.array!(@venues) do |venue|
  json.extract! venue, :id, :name, :address, :phone_number
  json.url venue_url(venue, format: :json)
end
