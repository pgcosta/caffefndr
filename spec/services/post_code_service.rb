require 'spec_helper'

RSpec.describe PostCodeService do
  describe "initialize" do
    it "should connect" do
      pc=PostCodeService.new("asdsa")
      expect(pc).not_to be_nil
    end
  end
end