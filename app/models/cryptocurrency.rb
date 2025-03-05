class Cryptocurrency < ApplicationRecord
  has_many :cryptocurrency_categories
  has_many :categories, through: :cryptocurrency_categories
  has_many :bets
  has_many :casino_tables, through: :bets

  validates :name, presence: true, uniqueness: true
  validates :symbol, presence: true
  validates :current_price_usd, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates :market_cap_usd, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates :volume_24h_usd, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
end
