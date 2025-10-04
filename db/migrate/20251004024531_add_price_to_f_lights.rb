class AddPriceToFLights < ActiveRecord::Migration[7.1]
  def change
    add_column :flights, :price, :integer
  end
end
