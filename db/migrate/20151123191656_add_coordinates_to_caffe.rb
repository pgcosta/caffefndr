class AddCoordinatesToCaffe < ActiveRecord::Migration
  def change
    add_column :caffes, :lat, :string
    add_column :caffes, :lon, :string
  end
end
