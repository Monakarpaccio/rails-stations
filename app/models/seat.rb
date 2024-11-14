class Seat < ApplicationRecord
  belongs_to :screen

  has_many :reservations, dependent: :destroy

  validates :seat_number, presence: true
end
