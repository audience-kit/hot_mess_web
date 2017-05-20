class VenuesController < ApplicationController
  # GET /events/1
  # GET /events/1.json
  def show
    @venue = Venue.find(params[:id])
    @title = @venue.data['name']
    @app_link = "events/#{@venue.data['id']}"
    @image = @venue.data['hero_url']
  end
end
