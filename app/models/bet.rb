class Bet < ApplicationRecord
  belongs_to :casino_table
  belongs_to :cryptocurrency

  
   validates :bet_type, presence: true, inclusion: { in: ['place_bet', 'cash_out'], message: "must be 'place_bet' or 'cash_out'" }
   validates :amount, presence: true, numericality: { greater_than: 0 }
   validates :odds, presence: true, numericality: { greater_than: 0 }
   validates :bet_time, presence: true
   
   # Calculate total value before validation
   before_validation :calculate_total_value
   
   private
   
   def calculate_total_value
     if amount.present? && odds.present?
       self.total_value = amount * odds
     end
   end
end
