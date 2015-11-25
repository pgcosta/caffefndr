class AddFieldsToCaffe < ActiveRecord::Migration
  def change
    add_column :caffes, :tip_count, :integer
    add_column :caffes, :popularity, :integer
    add_column :postal_codes, :searches_count, :integer
  end
end
