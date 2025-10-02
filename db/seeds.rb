require "json"

# Example: load users.json
file_path = Rails.root.join("db", "seeds", "offers.json")
flights = JSON.parse(File.read(file_path))

puts "cleaning database 🧹"
Flight.destroy_all
Airline.destroy_all

puts "Creating flights ✈"
# flights.data.each
flights["data"].each do |flight|
  airline = Airline.find_or_create_by(
    name: flight.dig("owner", "name"),
    logo: flight.dig("owner", "logo_symbol_url")
  )

  Flight.create!(
    airline: airline,
    flight_number: "#{ flight.dig("slices",0, "segments", 0,"marketing_carrier","iata_code")}#{flight.dig("slices",0,"segments",0,"operating_carrier_flight_number")}",
    origin: flight.dig("slices",0,"segments",0,"origin","name"),
    destination: flight.dig("slices",0,"segments",0,"destination","name"),
    price: flight.dig("total_amount"),
    departure: flight.dig("slices", 0, "segments", 0, "departing_at"),
    arrival: flight.dig("slices", 0, "segments", 0, "arriving_at")
  )

  puts "Done 👍"
end
# data.owner = airline
# [name: , logo_symbol_url:, iata_code: ]

# slices.first["name":]
# flight_number: , origin: , destination: , departure_date: , total_amount:

# 1. Update migrations with required fields
#    rails g migration AddFieldsToAirline logo_url:string name:string
#    add_column/remove_column :airlines, :logo, :string
# 2. Migrate db
# 3. Finish up the seed file
