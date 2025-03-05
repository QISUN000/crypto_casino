class Gambler < ApplicationRecord
  has_many :casino_tables

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP, message: "must be a valid email address" }
  validates :join_date, presence: true
end
