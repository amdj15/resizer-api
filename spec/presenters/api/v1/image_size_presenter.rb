require 'rails_helper'

describe Api::V1::ImageSizePresenter do
  let(:presenter) { Api::V1::ImageSizePresenter.new(FactoryGirl::create(:image_size), view) }

  describe "#link" do
    before do
      allow(presenter.h).to receive(:base_url){ "http://test_base_url" }
    end

    it "call base_url" do
      expect(presenter.h).to receive(:base_url)
      presenter.link
    end
  end
end
