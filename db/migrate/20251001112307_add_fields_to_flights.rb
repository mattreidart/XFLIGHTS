class AddFieldsToFlights < ActiveRecord::Migration[7.1]
  def change
    add_column :flights, :departure, :datetime
    add_column :flights, :arrival, :datetime
  end
end
