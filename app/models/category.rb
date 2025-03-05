class Category < ApplicationRecord
  has_many :cryptocurrency_categories
  has_many :cryptocurrencies, through: :cryptocurrency_categories

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
end
