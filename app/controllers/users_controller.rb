class UsersController < ApplicationController
  before_action :authenticate_user!
  def index
    @users = User.all
  end

  def show
    @user = current_user
    @bookings = @user.bookings.includes(:flight)
                     .where('flights.departure >= ?', Date.today)
                     .order('flights.departure ASC')
    @all_bookings = @user.bookings.all
  end

  def flight_params
    params.require(:flight).permit(:origin, :destination, :departure_date)
  end

  private
  def set_user
   @user = current_user
  end
end
