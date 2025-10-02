class RemoveDateFromFlights < ActiveRecord::Migration[7.1]
  def change
    remove_column :flights, :date, :string
  end
end
