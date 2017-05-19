class Admin::EventsController < Admin::AdminController
  before_action :set_event, only: [ :show, :edit, :destroy, :update ]

  def index
    @events = Event.all
  end

  def show
  end

  # GET /events/new
  def new
    graph = user.facebook_graph

    if params[:facebook_id]
      event = graph.get_object(params[:facebook_id])
      event['facebook_id'] = event.delete 'id'

      venue = Venue.find_or_initialize_by(facebook_id: event['venue']['id'])
      event.delete 'venue'

      @event = Event.new(event)
      @event.venue = venue

      if event['owner']['id'] != venue.facebook_id
        person = Person.find_or_create_by(facebook_id: event['owner']['id'])
        @event.person = person
      end

      if event['privacy'] && event['privacy'] != 'OPEN'
        flash.now[:danger] = 'This is not a public event'
      end
    else
      @event = Event.new
    end

    not_answered = graph.get_object('/me/events/not_replied')
    attending = graph.get_object('/me/events/attending')

    @importable_events = not_answered + attending
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to [:admin, @event], notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to admin_events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def import

  end

  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def event_params
    params.require(:event).permit(:start_time, :end_time, :name, :description, :venue_id, :person_id )
  end

  def set_event
    @event = Event.find(params[:id])
  end
end
