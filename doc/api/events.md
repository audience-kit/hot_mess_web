# Events

## Get Events

`GET /events.json`

Returns JSON Array with `event` objects.

`event` object defined as:

<code>
[{
  id: "{id}",
  url: "://{host}/events/{id}.json",
  created_at: "2014-10-27T09:44:55+00:00",
  updated_at: "2014-10-27T09:44:55+00:00",
  name: "Event Name",
  start_time: "2014-10-27T09:44:55+00:00",
  end_time: "2014-10-27T09:44:55+00:00",
  description: "Description of event",
  picture_url: "http://{some_image_url}"
},
{
  // More event objects
  ...
}]
</code>

## Get Single Event with Details

`GET /events/{id}.json`

Returns JSON object with event and related objects.

<code>
{
  id: "{id}",
  url: "://{host}/events/{id}.json",
  created_at: "2014-10-27T09:44:55+00:00",
  updated_at: "2014-10-27T09:44:55+00:00",
  name: "Event Name",
  start_time: "2014-10-27T09:44:55+00:00",
  end_time: "2014-10-27T09:44:55+00:00",
  description: "Description of event",
  venue: {
    id: "{venue id}"
    url: "://{host}/venues/{id}.json",
    created_at: "2014-10-27T09:44:55+00:00",
    updated_at: "2014-10-27T09:44:55+00:00",
    name: "Venue Name"
  },
  picture: {
    url: "http://{some_image_url}",
    width: 400,
    height: 300,
    :is_silhouette: false
  }
}
</code>