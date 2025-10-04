class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = current_user
    @bookings = @user.bookings.includes(:flight)
  end

  def flight_params
    params.require(:flight).permit(:origin, :destination, :departure_date)
  end
end
