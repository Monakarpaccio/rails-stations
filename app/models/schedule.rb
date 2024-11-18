class Schedule < ApplicationRecord
  has_many :reservations, dependent: :destroy
  belongs_to :screen, dependent: :destroy
  belongs_to :movie
end

