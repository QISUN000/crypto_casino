class CreateCryptocurrencies < ActiveRecord::Migration[8.0]
  def change
    create_table :cryptocurrencies do |t|
      t.string :api_id
      t.string :name
      t.string :symbol
      t.text :description
      t.string :logo_url
      t.string :website_url
      t.decimal :current_price_usd
      t.decimal :market_cap_usd
      t.decimal :volume_24h_usd
      t.decimal :price_change_24h
      t.decimal :price_change_percentage_24h
      t.integer :rank
      t.datetime :last_updated

      t.timestamps
    end
  end
end
