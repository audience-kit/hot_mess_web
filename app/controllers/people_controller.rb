class PeopleController < ApplicationController
  def index
  end

  def show
    if params[:id]
      @person = Person.find(params[:id])
    else
      @person = Person.find(session[:person_id])
    end
  end

  def new
  end

  def edit
  end

  def destroy
  end

  def create
  end
end
