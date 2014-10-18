class EventsController < ApplicationController
  # GET /events
  # GET /events.json
  def index
    midday = DateTime.new.at_midday
    @events = Event.where(:start_time.gte => midday)
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @event = Event.find(params[:id])
  end
end
