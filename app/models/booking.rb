class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :flight
  validates :first_name, :last_name, :gender, :date_of_birth, presence: true

  validates :phone_number,
  presence: true,
  format: {
    with: /\A(\+?61|0)[2-478](?:[ -]?[0-9]){8}\z/,
    message: "must be a valid Australian phone number"
  }
end
