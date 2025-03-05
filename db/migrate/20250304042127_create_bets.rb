class CreateBets < ActiveRecord::Migration[8.0]
  def change
    create_table :bets do |t|
      t.references :casino_table, null: false, foreign_key: true
      t.references :cryptocurrency, null: false, foreign_key: true
      t.string :bet_type
      t.decimal :amount
      t.decimal :odds
      t.decimal :total_value
      t.datetime :bet_time
      t.text :notes

      t.timestamps
    end
  end
end
