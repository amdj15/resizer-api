require 'rails_helper'

RSpec.describe ImageSize, type: :model do
  let(:image_size) { FactoryGirl::create :image_size }

  it { expect(image_size).to validate_presence_of :width }
  it { expect(image_size).to validate_presence_of :height }
  it { expect(image_size).to validate_numericality_of :width }
  it { expect(image_size).to validate_numericality_of :height }

  it { expect(image_size).to respond_to :image; }
end
