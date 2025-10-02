class AddAirlineRefToFlights < ActiveRecord::Migration[7.1]
  def change
    add_reference :flights, :airline, null: false, foreign_key: true
  end
end
