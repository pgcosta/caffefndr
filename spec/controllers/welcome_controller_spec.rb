require 'spec_helper'

RSpec.describe WelcomeController do
  describe "index" do
    it "should display a notice if the postcode is invalid" do
      allow_any_instance_of(PostCodeService).to receive(:valid?).and_return(false)

      get :index, postcode: "awdasdasd"
      expect(flash).not_to be_nil
    end

    it "should not display a notice if it has no postcode as params" do
      get :index
      expect(flash).to be_empty
    end
  end
end