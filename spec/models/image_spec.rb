require 'rails_helper'

RSpec.describe Image, type: :model do
  let(:image) { FactoryGirl::create :image }

  it { expect(image).to validate_presence_of :filename }
  it { expect(image).to respond_to :create_size }

  it "should to belong to gadget" do
    expect(image.gadget.class).to eq(Gadget)
  end

  describe "should have many image sizes" do
    it { expect(image).to respond_to :image_sizes }
    it { expect(image.image_sizes.class).to eq(Array) }
  end

  describe "#create_size" do
    let(:image_size) { FactoryGirl::create :image_size }

    before do
      allow(image).to receive(:resize_file)
    end

    it "should to call #resize_file" do
      expect(image).to receive(:resize_file)
      image.create_size image_size
    end

    it "should change image_sizes length" do
      expect{ image.create_size image_size }.to change{image.image_sizes.length}.by(1)
    end

    it "should return image_size" do
      expect(image.create_size(image_size).class).to eq(ImageSize)
    end
  end
end
