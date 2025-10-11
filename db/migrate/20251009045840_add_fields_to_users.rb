class AddFieldsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :title, :string
    add_column :users, :gender, :string
    add_column :users, :phone_number, :string
  end
end
