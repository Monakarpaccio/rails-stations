class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :validatable, :rememberable

  # ユーザーは複数の予約を持つ関連付け
  has_many :reservations, dependent: :destroy

  # バリデーション
  validates :name, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, length: { within: 6..128 }
  # パスワード確認も必須
  validates :password_confirmation, presence: true
end
