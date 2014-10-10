json.array!(@venues) do |venue|
  json.partial! 'shared/entity', entity: venue
  
  json.extract! venue, :facebook_id, :name, :phone, :about, :description

  if venue.picture :large
    json.picture_url venue.picture(:large).url
  end
end
