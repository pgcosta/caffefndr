require 'spec_helper'

RSpec.describe PostCodeService do
  describe "instance methods" do
    before(:each) do
      @post_code_stub = {
        "result" => {
          "latitude" => 11.11111,
          "longitude" => 22.22222,
          "postcode" => "abcd"
        }
      }
    end

    it "should connect" do
      pc=PostCodeService.new("asdsa")
      expect(pc).not_to be_nil
    end

    describe "get_postal_code" do
      it "should return an existing post_code" do
        PostalCode.destroy_all
        create :postal_code, postal_code: "abcd"
        pc = PostCodeService.new "xyz"
        pc.instance_variable_set :@post_code_data, @post_code_stub
        
        expect {
          pc.send(:get_postal_code)
        }.to change{PostalCode.count}.by(0)
      end

      it "should return new post_code if it is not on the database" do
        PostalCode.destroy_all
        pc = PostCodeService.new "xyz"
        pc.instance_variable_set :@post_code_data, @post_code_stub

        expect {
          pc.send(:get_postal_code)
        }.to change{PostalCode.count}.by(1)

        expect(PostalCode.last.postal_code).to eq("abcd")
      end
    end

    describe "coordinates" do
      it "should return a string with lat,long" do
        pc = PostCodeService.new "xyz"
        pc.instance_variable_set :@post_code_data, @post_code_stub
        expect(pc.send(:coordinates)).to eq("11.11111,22.22222")
      end
    end

    describe "get_caffes_array" do
      it "should return a correct array" do
        pc = PostCodeService.new "xyz"

        array=[]
        (1..5).each do |n|
          mash = Hashie::Mash.new
          mash.id = "xyz#{n}"
          mash.name = "Caffe xyz 1234"
          mash.location = Hashie::Mash.new
          mash.location.lat = "12.421422"
          mash.location.lon = "24.423434"
          mash.stats = Hashie::Mash.new
          mash.contact = Hashie::Mash.new
          array << mash
        end

        allow_any_instance_of(PostCodeService).to receive(:caffes_list).and_return(array)

        result = pc.send(:get_caffes_array)
        
        expect(result.count).to eq(5)
        expect(result.map(&:foursquare_id)).to eq(array.map(&:id))
      end
    end
  end
end