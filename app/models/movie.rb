class Movie < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :year, presence: true
  validates :description, presence: true
  validates :image_url, presence: true
end