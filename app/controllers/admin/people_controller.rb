class Admin::PeopleController < Admin::AdminController
  def index
    @people = Person.all
  end

  def show
    @person = Person.find(params[:id])
  end

  def new
    @person = Person.new
  end

  def create
    @person = Person.new(person_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to @person, flash: { success: 'Person was successfully created.' } }
        format.json { render :show, status: :created, location: @person }
      else
        format.html { render :new }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  def person_params
    params.require(:person)
  end
end
