class EventsController < ApplicationController

  # GET /events/1
  # GET /events/1.json
  def show
    @event = Event.find(params[:id])
    @title = @event.data['name']
    @app_link = "events/#{id}"
  end
end
