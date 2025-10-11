class AddCoordinatesToFlights < ActiveRecord::Migration[7.1]
  def change
    add_column :flights, :origin_lat, :float
    add_column :flights, :origin_lng, :float
    add_column :flights, :destination_lat, :float
    add_column :flights, :destination_lng, :float
  end
end
