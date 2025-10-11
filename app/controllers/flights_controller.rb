class FlightsController < ApplicationController
  # GET /flights/search
  def search
    # Ensure params are present
    flight_params = params.fetch(:flight, {})
    origin = flight_params[:origin].presence
    destination = flight_params[:destination].presence
    departure = flight_params[:departure].presence

    # Initialize @flights as empty relation by default
    @flights = Flight.none

    # Only query if at least origin and destination are present
    if origin && destination && departure
      # Convert departure param to date
      begin
        departure_date = Date.parse(departure)
        @flights = Flight.where(origin: origin, destination: destination)
                        .where(departure: departure_date.beginning_of_day..departure_date.end_of_day)
      rescue ArgumentError
        @flights = Flight.none
      end
    end
  end
end
