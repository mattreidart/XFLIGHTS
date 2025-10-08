class AddFieldsToBookings < ActiveRecord::Migration[7.1]
  def change
    add_column :bookings, :title, :string
    add_column :bookings, :first_name, :string
    add_column :bookings, :middle_name, :string
    add_column :bookings, :last_name, :string
    add_column :bookings, :phone_number, :string
    add_column :bookings, :gender, :string
    add_column :bookings, :date_of_birth, :date
  end
end
