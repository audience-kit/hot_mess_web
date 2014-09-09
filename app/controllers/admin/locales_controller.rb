class Admin::LocalesController < Admin::AdminController
  before_action :set_locale, only: [:show, :edit, :update, :destroy]

  def index
    @locales = Locale.all
  end

  def new
    @locale = Locale.new
  end

  def create
    @locale = Locale.new(locale_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to @locale, flash: { success: 'Locale created successfully.' } }
        format.json { render :show, status: :created, location: @locale }
      else
        format.html { render :new }
        format.json { render json: @locale.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  private
  def set_locale
    @locale = Locale.find(params[:id])
  end

  def locale_params
    params.require(:locale)
  end
end
