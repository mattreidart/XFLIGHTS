class FlightsController < ApplicationController
  def index
    @flights = Flight.all
  end

  def show
  end

  def search
    # API call, remember to run bundle install
    response = HTTParty.post(
      'https://api.duffel.com/air/offer_requests',
      headers: {
        'Authorization' => "Bearer #{ENV['DUFFEL_API_KEY']}",
        'Content-Type' => 'application/json',
        'Duffel-Version' => 'v2'
      },
      body: {
        data: {
          slices: [
            {
              origin: params[:origin],
              destination: params[:destination],
              departure_date: params[:departure_date]
            }
          ],
          # Passenger types: adult, child, infant_without_seat
          passengers: [
            { type: params[:type]}
          ],
          # Cabin classes: economy, premium_economy, business, first
          cabin_class: params[:cabin_class]
        }
      }.to_json
    )

    #checks if API call was successful
    if response.success?
      @offer_request_id = response['data'].first['id']

      offers_request = HTTParty.get(
        "https://api.duffel.com/air/offers?offer_request_id=#{@offer_request_id}",
        headers: {
          'Authorization' => "Bearer #{ENV['DUFFEL_API_KEY']}",
          'Duffel-Version' => 'v2'
        }
      )
      if offers_request.success?
        @offers = offers_request['data']
      else
        flash[:error] = "unable to fetch orders"
        redirect_to root_path
      end
    else
      flash[:error] = "Search failed: #{response['errors']&.first&.dig('message')}"
      redirect_to root_path
    end
  end

  private

  def set_flight
    @flight = Flight.find(params[:id])
  end
end


