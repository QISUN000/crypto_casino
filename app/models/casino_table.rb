class CasinoTable < ApplicationRecord
  belongs_to :gambler
  has_many :bets
  has_many :cryptocurrencies, through: :bets

  validates :name, presence: true
  validates :gambler_id, presence: true
end
