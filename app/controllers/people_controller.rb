class PeopleController < ApplicationController
  def index
    @people = Person.are_public

    respond_to do |format|
      format.html
      format.json
    end
  end

  def show
    if params[:id]
      @person = Person.find(params[:id])
    else
      @person = Person.find(session[:person_id])
    end

    respond_to do |format|
      format.html
      format.json
    end
  end
end
