class CryptocurrencyCategory < ApplicationRecord
  belongs_to :cryptocurrency
  belongs_to :category

  validates :cryptocurrency_id, uniqueness: { scope: :category_id, message: "already belongs to this category" }
end
