class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :commodity_ownerships, dependent: :destroy
  has_many :commodity_transactions, dependent: :destroy

  validates :email_address, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  normalizes :email_address, with: ->(e) { e.strip.downcase }
end
