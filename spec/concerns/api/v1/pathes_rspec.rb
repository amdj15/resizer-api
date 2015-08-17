require 'rails_helper'

RSpec.describe Api::V1::Pathes do
  before(:all) do
    PathesHolder = Class.new do
      include Pathes
      attr_reader :filename

      def initialize
        @filename = "#{SecureRandom.uuid}.jpg"
      end
    end
  end

  let(:pathesHolder) { PathesHolder.new }

  before do
    allow(pathesHolder).to receive(:path_for_file) { "sd/sd" }
  end

  describe "#public_file_path" do
    def pfp
      pathesHolder.public_file_path("10", "15")
    end

    before do
      allow(FileUtils).to receive(:mkdir_p)
    end

    it "should call #path_for_file" do
      expect(pathesHolder).to receive(:path_for_file)
      pfp
    end

    context "directory doesnt exists" do
      before do
        allow(File).to receive(:directory?) { false }
      end

      it "have to create new directory" do
        expect(FileUtils).to receive(:mkdir_p)
        pfp
      end
    end
  end

  describe "#private_file_path" do
    def prfp(include_file)
      pathesHolder.private_file_path(pathesHolder.filename, include_file)
    end

    it "have call #path_for_file" do
      expect(pathesHolder).to receive(:path_for_file)
      prfp(false)
    end

    context "with file" do
      it "have to return path to file including file name" do
        expect(prfp(true)).to match pathesHolder.filename
      end
    end

    context "without file" do
      it "have to return path to file without file name" do
        expect(prfp(false)).not_to match pathesHolder.filename
      end
    end
  end

  describe "#link_to_file" do
    def lp
      pathesHolder.link_path(200, 300)
    end

    it "have to call #path_for_file" do
      expect(pathesHolder).to receive(:path_for_file)
      lp
    end

    it "have to include filename" do
      expect(lp).to match File.basename(pathesHolder.filename, ".*").to_s
    end
  end
end