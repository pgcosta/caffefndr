class PostalCodeAndCaffeManyToManyRelation < ActiveRecord::Migration
  def change
  	remove_column :caffes, :postal_code_id

  	create_table :caffes_postal_codes, id: false do |t|
  		t.belongs_to :caffe, index: true
  		t.belongs_to :postal_code, index: true
		end
  end
end
