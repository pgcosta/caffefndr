class RemoveDistanceFromCaffe < ActiveRecord::Migration
  def change
    remove_column :caffes, :distance
  end
end
