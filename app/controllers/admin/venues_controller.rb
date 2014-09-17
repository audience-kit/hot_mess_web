class Admin::VenuesController < Admin::AdminController

  before_action :set_venue, only: [:show, :edit, :update, :destroy]

  # GET /venues
  # GET /venues.json
  def index
    @venues = Venue.includes(:picture).all
  end

  # GET /venues/1
  # GET /venues/1.json
  def show
  end

  # GET /venues/new
  def new
    @venue = Venue.new
  end

  # GET /venues/1/edit
  def edit
  end

  # POST /venues
  # POST /venues.json
  def create
    @venue = Venue.new(venue_params)

    respond_to do |format|
      if @venue.save
        format.html { redirect_to [:admin, @venue], flash: { success: 'Venue was successfully created.' } }
        format.json { render :show, status: :created, location: @venue }
      else
        format.html { render :new }
        format.json { render json: @venue.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /venues/1
  # PATCH/PUT /venues/1.json
  def update
    respond_to do |format|
      if @venue.update(venue_params)
        format.html { redirect_to [:admin, @venue], flash: { success: 'Venue was successfully updated.' } }
        format.json { render :show, status: :ok, location: @venue }
      else
        format.html { render :edit }
        format.json { render json: @venue.errors, status: :unprocessable_entity }
      end
    end
  end

  def import
    params.require(:import_venue_page)
    page_name = params[:import_venue_page]
    logger.debug "\tRequested to import Facebook page #{page_name}"

    graph = facebook_graph
    app_import = true

    begin
      page = graph.get_page(page_name).with_indifferent_access
    rescue
      graph = user.facebook_graph
      app_import = false
    end

    begin
      page = graph.get_page(page_name).with_indifferent_access
    rescue
      render flash: { danger: "Could not find page with name #{page_name}" }
    end

    logger.debug "\tGot Facebook page => #{page.inspect}"

    @venue = Venue.find_or_initialize_by(facebook_id: page[:id])

    page.delete(:id)

    page.each do |key,value|
      @venue[key.to_s] = value
    end

    @venue.imported_at = DateTime.now.utc
    if app_import
      @venue.imported_by = nil
    else
      @venue.imported_by = user
    end

    photo = graph.get_connections(@venue.facebook_id, "picture?redirect=false&type=large")['data']
    logger.debug "\tGot Facebook photo for page => #{photo.inspect}"
    @venue.build_picture unless @venue.picture

    photo.each do |key,value|
      @venue.picture[key.to_s] = value
    end
    @venue.picture.save

    respond_to do |format|
      if @venue.save
        format.html { redirect_to [:admin, @venue], flash: { success: 'Venue was successfully created.' } }
        format.json { render :show, status: :created, location: @venue }
      else
        format.html { render :new }
        format.json { render json: @venue.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_events

  end

  # DELETE /venues/1
  # DELETE /venues/1.json
  def destroy
    @venue.destroy
    respond_to do |format|
      format.html { redirect_to venues_url, notice: 'Venue was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_venue
    @venue = Venue.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def venue_params
    params.require(:venue).permit(:name, :address, :phone_number)
  end
end
