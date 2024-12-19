class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :commodity_ownerships, dependent: :destroy
  has_many :commodity_transactions, dependent: :destroy

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  normalizes :email, with: ->(e) { e.strip.downcase }
end
