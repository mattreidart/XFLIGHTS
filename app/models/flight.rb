class Flight < ApplicationRecord
  has_many :bookings
  belongs_to :airline
end
