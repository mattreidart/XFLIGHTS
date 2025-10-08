class Flight < ApplicationRecord
  has_many :bookings
  belongs_to :airline
  has_many :users, through: :bookings
end
