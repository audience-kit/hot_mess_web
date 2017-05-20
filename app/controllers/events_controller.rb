class EventsController < ApplicationController

  # GET /events/1
  # GET /events/1.json
  def show
    @event = Event.find(params[:id])
    @title = @event.data['name']
    @app_link = "events/#{@event.data['id']}"
    @image = @event.data['cover_photo_url']
  end
end
