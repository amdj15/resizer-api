require 'rails_helper'

RSpec.describe Gadget, type: :model do
  let(:gadget) { FactoryGirl::create :gadget }

  it { expect(gadget).to respond_to :images }

  describe "#images" do
    it { expect(gadget.images.class).to be Array }
  end

  describe "Gadget class" do
    it { expect(gadget.class).to respond_to :generate_token }

    it 'should generate uniq token' do
      expect(Gadget.find_by_token(Gadget.generate_token)).to eq(nil)
    end
  end
end
