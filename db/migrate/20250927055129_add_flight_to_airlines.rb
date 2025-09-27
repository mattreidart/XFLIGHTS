class AddFlightToAirlines < ActiveRecord::Migration[7.1]
  def change
    add_reference :airlines, :flight, null: false, foreign_key: true
  end
end
