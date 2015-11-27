require 'spec_helper'

RSpec.describe PostalCode do
  describe "hooks" do
    describe "after_create" do
      it "should set the searches counter to 0" do
        pc = create :postal_code
        expect(pc.searches_count).to eq(0)
      end
    end
  end

  describe "instance methods" do
    it "should return an array of arrays with all the caffes associated" do
      pc = create :postal_code
      caffes = []
      (1..7).each do
        caffes << (create :caffe)
      end

      pc.caffes << caffes
      pc.save!
      pc.reload
      expected_array = caffes.inject([]) {|acc,x| acc<<[x.name,x.lat,x.lon]}

      expect(pc.caffes.count).to eq(7)
      expect(pc.gmaps_points_of_caffes).to eq(expected_array)
    end
  end
end