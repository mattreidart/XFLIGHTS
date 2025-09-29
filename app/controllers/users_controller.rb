class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end
  def show
    @user = current_user
    @bookings = @user.bookings.includes(:flight)
  end
end
