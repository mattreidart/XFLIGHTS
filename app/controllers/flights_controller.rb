class FlightsController < ApplicationController
  def index
    @flights = Flight.all
  end

  def show
  end

  def search
    #All flights
    @flights = Flight.all
    #access params[search]

    #Match origin and destination
    @flights = @flights.where(origin: params[:origin]) if params[:origin].present?
    @flights = @flights.where(destination: params[:destination]) if params[:destination].present?
    @flights = @flights.where(departure: params[:departure].to_date.all_day) if params[:departure].present?

    flash.now[:notice] = 'No matching flights found.' if @flights.empty?
    #check to see if return flight is included
    # if search_params[:round_trip].present? && search_params[:return_date].present?
    #   @return_flights = Flight.all
    #   @return_flights = @return_flights.where(origin: search_params[:destination])
    #   @return_flights = @return_flights.where(destination: search_params[:origin])
    #   @return_flights = @return_flights.where(departure: search_params[:return_date].to_date.all_day)
    #   flash.now[:notice] = 'No matching return flights found.' if @return_flights.empty?
    # end
  end

  private

  def set_flight
    @flight = Flight.find(params[:id])
  end
end
