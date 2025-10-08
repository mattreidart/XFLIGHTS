class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :flight

  validates :first_name, :last_name, :phone_number, :gender, :date_of_birth, presence: true
end
