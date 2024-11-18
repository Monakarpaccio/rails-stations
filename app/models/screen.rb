class Screen < ApplicationRecord
  has_many :schedules
  has_many :seats, dependent: :destroy
  has_many :reservations, through: :seats
end
