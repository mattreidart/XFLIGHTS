class AddColumnNameToBookings < ActiveRecord::Migration[7.1]
  def change
    add_column :bookings, :price, :integer
  end
end
