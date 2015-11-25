class AddTimeoutToPostalCode < ActiveRecord::Migration
  def change
    add_column :postal_codes, :foursquare_timeout, :datetime
  end
end
