class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :bookings
  has_many :flights, through: :bookings

  validates :title, :gender, :first_name, :last_name, :date_of_birth, :phone_number, presence: true
  validates :phone_number, format: {
    with: /\A(\+?61|0)[2-478](?:[ -]?[0-9]){8}\z/,
    message: "must be a valid Australian phone number"
  }
end
