class BookingsController < ApplicationController
  before_action :set_booking, only: %i[show destroy]
  before_action :authenticate_user!

  def index
    sort = params[:sort]
    dir = params[:direction] == "desc" ? "desc" : "asc"
    map = {
      "airline" => "airlines.name",
      "route" => Arel.sql("flights.origin || '-' || flights.destination"),
      "departure" => "flights.departure",
      "arrival" => "flights.arrival"
    }
    order_clause = map[sort] ? "#{map[sort]} #{dir}" : "bookings.created_at DESC"
    @bookings = Booking.includes(flight: :airline).joins(flight: :airline).order(Arel.sql(order_clause))
  end

  def new
    @flight = Flight.find(params[:flight_id])
    @booking = current_user.bookings.new(flight: @flight)
    @user = current_user
  end

  def show
    @booking = current_user.bookings.find_by(id: params[:id])
    return redirect_to bookings_path, alert: "Booking not found or access denied." unless @booking
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
    @booking = Booking.find(params[:id])
    @booking.destroy
    redirect_to bookings_path, notice: "Booking successfully deleted"
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
