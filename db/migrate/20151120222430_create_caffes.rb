class CreateCaffes < ActiveRecord::Migration
  def change
    create_table :caffes do |t|
      t.string :foursquare_id
      t.string :name
      t.string :twitter
      t.string :address
      t.string :city
      t.integer :distance
      t.integer :checkins_count
      t.integer :users_count
      t.string :postal_code_id

      t.timestamps null: false
    end
  end
end
