class Sheet < ApplicationRecord
  belongs_to :screen
  has_many :reservations

  validates :sheet_number, presence: true, uniqueness: { scope: :screen_id, message: "その座席番号はすでに存在します" }
end
