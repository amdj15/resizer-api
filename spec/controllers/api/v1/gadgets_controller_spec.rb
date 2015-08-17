require 'rails_helper'

RSpec.describe Api::V1::GadgetsController, type: :controller do
  describe "GET #new" do
    def reqnew
      get :new, format: :json
    end

    it "return http success" do
      expect(response).to have_http_status(:success)
      reqnew
    end

    it "render new template" do
      reqnew
      expect(response).to render_template(:new)
    end

    it "should set @gadget instance variable" do
      expect{ reqnew }.to change{ subject.instance_variable_get(:@gadget) }
    end

    it "have should create new gadget" do
      expect(Gadget).to receive(:create!)
      reqnew
    end
  end
end
