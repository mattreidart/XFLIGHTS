class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :destroy]
  before_action :authenticate_user!

  def index
    @bookings = current_user.bookings
    # flash[:notice] = "This is a random message"
  end

  def new
  end

  def create
    # redirect_to booking_path(@booking), notice: "Booking successfully created"
  end

end
