class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :destroy]
  before_action :authenticate_user!

  def index
    @bookings = current_user.bookings.includes(:flight)
    # flash[:notice] = "This is a random message"
  end

  def new
    @flight = Flight.find(params[:flight_id])
    @booking = current_user.bookings.new(flight: @flight)
  end

  def show

  end

  def create
    @flight = Flight.find(params[:flight_id])
    @booking = current_user.bookings.new(booking_params.merge(flight: @flight, status: 'confirmed'))

    if @booking.save
      redirect_to booking_path(@booking), notice: "Booking successfully created"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @booking.destroy
    redirect_to bookings_path, notice: "Booking successfully cancelled"
  end

  private

  def set_booking
    @booking = current_user.bookings.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:title, :first_name, :last_name, :middle_name, :date_of_birth, :gender, :phone_number)
    # or possibly passenger.name and passenger.email etc
  end
end
