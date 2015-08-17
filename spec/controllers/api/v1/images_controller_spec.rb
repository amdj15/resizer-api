require 'rails_helper'

RSpec.describe Api::V1::ImagesController, type: :controller do
  let(:gadget) { FactoryGirl::create :gadget }

  before do
    subject.class.skip_before_filter :check_access_token!
    subject.instance_variable_set(:@gadget, gadget)
  end

  describe "GET #index" do
    def index
      get :index, format: :json
    end

    it "return http success" do
      expect(response).to have_http_status(:success)
      index
    end

    it "have to render index template" do
      index
      expect(response).to render_template :index
    end

    it "should set @images instance variable" do
      expect{ index }.to change{ subject.instance_variable_get(:@images) }
    end
  end

  describe "image processing" do
    let(:image) { FactoryGirl::create :image }
    let(:image_size) { FactoryGirl::create :image_size }
    let(:invalid_image_size) { FactoryGirl::build_stubbed :invalid_image_size }

    before do
      allow(subject).to receive(:get_image) { image }
      allow(ImageSize).to receive(:new).and_return(image_size)
      allow(subject).to receive(:create_size)
    end

    describe "POST #resize" do
      def resize(width: 100, height: 100)
        post :resize, id: image.id, width: width, height: height, format: :json
      end

      it "create new image size" do
        expect(ImageSize).to receive(:new)
        resize
      end

      it "have to render create template" do
        resize
        expect(response).to render_template :create
      end

      context "size is not valid" do
        before do
          allow(ImageSize).to receive(:new).and_return(invalid_image_size)
        end

        it "should not to resize image" do
          expect(subject).not_to receive(:create_size)
          resize
        end

        it "have to call #api_error" do
          expect(subject).to receive(:api_error).at_least(:once)
          resize
        end
      end
    end

    describe "POST #create" do
      let(:uploader) do
        Class.new do
          attr_reader :filename

          def initialize
            @filename = "file.ext"
          end

          def store!(*args)
          end
        end
      end

      def create
        post :create, width: 300, height: 300, format: :json
      end

      before do
        allow(ImageUploader).to receive(:new).and_return(uploader.new)
      end

      it "should create uploader" do
        expect(ImageUploader).to receive(:new)
        create
      end

      it "should call #process_image" do
        expect(subject).to receive(:process_image)
        create
      end

      it "should call #create_size" do
        expect(subject).to receive(:create_size)
        create
      end

      context "bad image sizes" do
        before do
          allow(ImageSize).to receive(:new).and_return(invalid_image_size)
        end

        it "should not to resize image" do
          expect(subject).not_to receive(:create_size)
          create
        end

        it "have to call #api_error" do
          expect(subject).to receive(:api_error).at_least(:once)
          create
        end
      end
    end
  end
end