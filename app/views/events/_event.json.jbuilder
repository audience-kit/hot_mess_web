json.partial! 'shared/entity', entity: event

json.extract! event, :start_time, :end_time, :name, :description

if event.picture :large
  json.picture_url event.picture(:large).url
end