class CreateAirlines < ActiveRecord::Migration[7.1]
  def change
    create_table :airlines do |t|
      t.string :name
      t.string :logo
      t.timestamps
    end
  end
end
