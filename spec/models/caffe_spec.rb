require 'spec_helper'

RSpec.describe Caffe do
  describe "validations" do
    describe "foursquare_id" do
      it "should be unique" do
        create :caffe, foursquare_id: '1234'
        expect {
          create :caffe, foursquare_id: '1234'
        }.to raise_error
      end
    end
  end

  describe "hooks" do
    describe "before_save" do
      it "should generate popularity ranking" do
        c = create :caffe, checkins_count: 40, users_count: 40, tip_count: 15
        c.reload

        expect(c.popularity).not_to be_nil
      end
    end

    describe "class methods" do
      describe "build_from_hashie" do
        it "should create a new Caffe from a Hashie" do
          mash = Hashie::Mash.new
          mash.id = "2763egyu23g23s"
          mash.name = "Caffe 1"
          mash.location = Hashie::Mash.new
          mash.location.lat = "12.421422"
          mash.location.lon = "24.423434"
          mash.stats = Hashie::Mash.new
          mash.contact = Hashie::Mash.new

          Caffe.destroy_all

          expect{
            Caffe.build_from_hashie mash
          }.to change{Caffe.count}.by(1)
        end

        it "should update a Caffe from a Hashie" do
          Caffe.destroy_all
          caffe = create :caffe, foursquare_id: foursquare_id="2763egyu23g23s"

          mash = Hashie::Mash.new
          mash.id = foursquare_id
          mash.name = "Caffe xyz 1234"
          mash.location = Hashie::Mash.new
          mash.location.lat = "12.421422"
          mash.location.lon = "24.423434"
          mash.stats = Hashie::Mash.new
          mash.contact = Hashie::Mash.new

          expect{
            Caffe.build_from_hashie mash
          }.to change{Caffe.count}.by(0)

          expect(Caffe.last.name).to eq(mash.name)
        end
      end
    end
  end
end