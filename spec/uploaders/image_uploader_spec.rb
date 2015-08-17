require 'rails_helper'

RSpec.describe ImageUploader do
  it { expect(subject).to respond_to :store_dir }
  it { expect(subject).to respond_to :filename }

  it { expect(subject.class).to respond_to :storage }

  describe "#filename" do
    before { allow(subject).to receive_message_chain('file.extension').and_return("jpg") }

    context "name is not generated" do
      it "file name should be nil at the begin" do
        expect(subject.instance_variable_get(:@uniq_name)).to be_nil
      end

      it "have to generate filename" do
        expect(SecureRandom).to receive(:uuid)
        subject.filename
      end

      it "have to set generated filename to instance variable" do
        expect{ subject.filename }.to change{ subject.instance_variable_get(:@uniq_name) }
      end
    end

    context "name already generated" do
      def fname
        "random_file_name.jpg"
      end

      before { subject.instance_variable_set(:@uniq_name, fname) }

      it "have not to generate filename" do
        expect(SecureRandom).not_to receive(:uuid)
        subject.filename
      end

      it "should return filename from instance variable" do
        expect(subject.filename).to eq fname
      end
    end
  end
end