class CreatePostalCodes < ActiveRecord::Migration
  def change
    create_table :postal_codes do |t|
      t.string :lat
      t.string :long
      t.string :postal_code

      t.timestamps null: false
    end
  end
end
