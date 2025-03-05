class CreateCryptocurrencyCategories < ActiveRecord::Migration[8.0]
  def change
    create_table :cryptocurrency_categories do |t|
      t.references :cryptocurrency, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
