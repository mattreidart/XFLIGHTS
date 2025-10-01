class FlightsController < ApplicationController
  def index
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
end


# Example of what will return:
# {

#   "meta": {

#       "before": null,

#       "limit": 50,

#       "after": null

#   },

#   "data": [{

#       "available_airline_credits": [],

#       "cabin_class": "economy",

#       "live_mode": false,

#       "created_at": "2025-09-30T00:30:04.193088Z",

#       "slices": [{

#           "destination_type": "airport",

#           "origin_type": "airport",

#           "departure_date": "2025-10-15",

#           "destination": {

#               "airports": null,

#               "iata_country_code": "US",

#               "iata_city_code": "NYC",

#               "city_name": "New York",

#               "icao_code": "KJFK",

#               "iata_code": "JFK",

#               "latitude": 40.640556,

#               "longitude": -73.778519,

#               "city": {

#                   "iata_country_code": "US",

#                   "iata_city_code": "NYC",

#                   "city_name": null,

#                   "icao_code": null,

#                   "iata_code": "NYC",

#                   "latitude": null,

#                   "longitude": null,

#                   "time_zone": null,

#                   "type": "city",

#                   "name": "New York",

#                   "id": "cit_nyc_us"

#               },

#               "time_zone": "America/New_York",

#               "type": "airport",

#               "name": "John F. Kennedy International Airport",

#               "id": "arp_jfk_us"

#           },

#           "origin": {

#               "airports": null,

#               "iata_country_code": "GB",

#               "iata_city_code": "LON",

#               "city_name": "London",

#               "icao_code": "EGLL",

#               "iata_code": "LHR",

#               "latitude": 51.470311,

#               "longitude": -0.458118,

#               "city": {

#                   "iata_country_code": "GB",

#                   "iata_city_code": "LON",

#                   "city_name": null,

#                   "icao_code": null,

#                   "iata_code": "LON",

#                   "latitude": null,

#                   "longitude": null,

#                   "time_zone": null,

#                   "type": "city",

#                   "name": "London",

#                   "id": "cit_lon_gb"

#               },

#               "time_zone": "Europe/London",

#               "type": "airport",

#               "name": "Heathrow Airport",

#               "id": "arp_lhr_gb"

#           }

#       }],

#       "passengers": [{

#           "fare_type": null,

#           "loyalty_programme_accounts": [],

#           "family_name": null,

#           "given_name": null,

#           "age": null,

#           "type": "adult",

#           "id": "pas_0000AyiORgDZSOBaKPmm9F"

#       }],

#       "client_key": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE3NTkyNzg2MTYsIm9yZ2FuaXNhdGlvbl9pZCI6Im9yZ18wMDAwQXloQjE5QjVZWk1VeEd3S2dxIiwibGl2ZV9tb2RlIjpmYWxzZSwicGxhdGZvcm1fdXNlcl9pZCI6bnVsbH0.fW66_c2sne-Z_s6-6QS1ocesNnAdFISjJXz4_RQOASw",

#       "id": "orq_0000AyiORgDZSOBaKPmm9C"

#   }]

# }
