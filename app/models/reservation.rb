class Reservation < ApplicationRecord
  belongs_to :schedule
  belongs_to :sheet
  belongs_to :movie, optional: true
  
  validates :date, presence: true
  validates :email, presence: true, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }

  validates :name, presence: true
  # 同じスケジュール、日付、座席の組み合わせの重複を禁止
  validates :schedule_id, uniqueness: { scope: [:sheet_id, :date], message: "その座席はすでに予約済みです" }
end
