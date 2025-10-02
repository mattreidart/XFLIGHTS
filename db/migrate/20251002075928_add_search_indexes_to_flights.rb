class AddSearchIndexesToFlights < ActiveRecord::Migration[7.1]
  def change
    add_index :flights, :origin
    add_index :flights, :destination
    add_index :flights, :departure
  end
end
