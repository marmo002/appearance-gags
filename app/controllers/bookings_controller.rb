class BookingsController < ApplicationController
  before_action :require_login
  before_action :signed_release, only: [:new]

  def index

  end

  def new
    @booking = Booking.new
    @show = params[:show_name]
    @type = params[:type]
  end

  def create

  end

  private

  def signed_release
    unless current_user.signed_release
      flash[:warning] = "Please signed release before booking a show"
      # redirect_to dashboard_url, page: "release"
      redirect_to controller: 'dashboard', action: 'index', page: 'release-tab'
    end
  end

end
