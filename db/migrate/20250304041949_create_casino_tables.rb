class CreateCasinoTables < ActiveRecord::Migration[8.0]
  def change
    create_table :casino_tables do |t|
      t.references :gambler, null: false, foreign_key: true
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
