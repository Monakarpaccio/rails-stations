class Screen < ApplicationRecord
  belongs_to :movie
  has_many :seats, dependent: :destroy
  has_many :reservations, through: :seats
end
