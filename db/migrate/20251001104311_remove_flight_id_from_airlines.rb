class RemoveFlightIdFromAirlines < ActiveRecord::Migration[7.1]
  def up
    remove_foreign_key :airlines, :flights
    remove_column :airlines, :flight_id
  end

  def down
    add_column :airlines, :flight_id, :bigint, null: false
    add_foreign_key :airlines, :flights
  end
end
