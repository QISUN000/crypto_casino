class CreateGamblers < ActiveRecord::Migration[8.0]
  def change
    create_table :gamblers do |t|
      t.string :name
      t.string :email
      t.text :bio
      t.datetime :join_date
      t.string :profile_image_url

      t.timestamps
    end
  end
end
