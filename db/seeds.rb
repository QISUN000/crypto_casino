# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'httparty'
require 'faker'
require 'csv'
require 'json'

Bet.destroy_all
CasinoTable.destroy_all
Gambler.destroy_all
CryptocurrencyCategory.destroy_all
Category.destroy_all
Cryptocurrency.destroy_all

# Fetching cryptocurrency data from Coinranking API
response = HTTParty.get('https://api.coinranking.com/v2/coins?limit=50')
if response.success?
  data = JSON.parse(response.body)['data']['coins']
  data.each do |coin|
    Cryptocurrency.create!(
      api_id: coin['uuid'],
      name: coin['name'],
      symbol: coin['symbol'],
      logo_url: coin['iconUrl'],
      current_price_usd: coin['price'].to_f,
      market_cap_usd: coin['marketCap'].to_f,
      volume_24h_usd: coin['24hVolume'].to_f,
      price_change_24h: coin['change'].to_f,
      rank: coin['rank'].to_i,
      last_updated: Time.now
    )
  end
else
  puts "Failed to fetch data from API"
end

# Importing cryptocurrency categories from CSV
categories_csv_path = Rails.root.join('db', 'data', 'crypto_categories.csv')
if File.exist?(categories_csv_path)
  CSV.foreach(categories_csv_path, headers: true) do |row|
    Category.create!(
      name: row['name'],
      description: row['description']
    )
  end
  puts "Imported #{Category.count} cryptocurrency categories"
else
  puts "CSV file not found at #{categories_csv_path}"
end

categories = Category.all

Cryptocurrency.all.each do |crypto|
  random_categories = categories.sample(rand(1..3))
  
  # Create the associations
  random_categories.each do |category|
    CryptocurrencyCategory.create!(
      cryptocurrency: crypto,
      category: category
    )
  end
  
  crypto.update(
    description: "#{crypto.name} (#{crypto.symbol}) is a cryptocurrency with a current price of $#{crypto.current_price_usd.round(2)}.",
    website_url: "https://www.#{crypto.name.downcase.gsub(' ', '')}.org"
  )
end

# Generating gamblers using Faker
50.times do
  Gambler.create!(
    name: Faker::Name.name,
    email: Faker::Internet.unique.email,
    bio: Faker::Lorem.paragraph(sentence_count: 2),
    join_date: Faker::Date.between(from: 2.years.ago, to: Date.today),
    profile_image_url: "https://randomuser.me/api/portraits/#{['men', 'women'].sample}/#{rand(1..99)}.jpg"
  )
end

# Create casino tables and bets
puts "Creating casino tables and bets..."
Gambler.all.each do |gambler|
  rand(1..3).times do
    table = CasinoTable.create!(
      gambler: gambler,
      name: "#{['Golden', 'Silver', 'Diamond', 'Platinum', 'Ruby', 'Emerald'].sample} #{['Stakes', 'Chips', 'Deck', 'Wheel'].sample}",
      description: Faker::Lorem.sentence(word_count: 10)
    )
    
    # Each casino table has 3-10 bets
    rand(3..10).times do
      crypto = Cryptocurrency.all.sample
      bet_time = Faker::Date.between(from: 1.year.ago, to: Date.today)
      
      Bet.create!(
        casino_table: table,
        cryptocurrency: crypto,
        bet_type: ['place_bet', 'cash_out'].sample,
        amount: rand(0.1..10.0).round(4),
        odds: crypto.current_price_usd * rand(0.8..1.2), # Random odds around current price
        bet_time: bet_time,
        notes: rand < 0.3 ? Faker::Lorem.sentence : nil
      )
    end
  end
end

puts "Seed completed successfully!"
puts "Created #{Cryptocurrency.count} cryptocurrencies from Coinranking API"
puts "Created #{Category.count} categories from CSV"
puts "Created #{Gambler.count} gamblers with Faker"
puts "Created #{CasinoTable.count} casino tables"
puts "Created #{Bet.count} bets"
puts "Total rows in database: #{Cryptocurrency.count + Category.count + CryptocurrencyCategory.count + Gambler.count + CasinoTable.count + Bet.count}"