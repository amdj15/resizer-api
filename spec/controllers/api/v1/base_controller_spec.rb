require 'rails_helper'

describe Api::V1::BaseController, type: :controller do
  controller do
    def index
      render :text => ""
    end
  end

  describe "#check_access_token!" do
    it "should get token and otions" do
      expect(ActionController::HttpAuthentication::Token).to receive(:token_and_options)
      get :index
    end

    it "should find user by token" do
      expect(subject).to receive(:set_gadget)
      get :index
    end

    context "Bad token given" do
      before do
        allow(ActionController::HttpAuthentication::Token).to receive(:token_and_options).and_return(nil)
      end

      it "should call #api_error" do
        expect(subject).to receive(:api_error)
        get :index
      end
    end
  end
end
