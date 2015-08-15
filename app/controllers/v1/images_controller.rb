class V1::ImagesController < V1::BaseController
  def index
    @images = @gadget.images
  end

  def create
    uploader = ImageUploader.new
    uploader.store! params[:file]

    image = Image.create!(filename: uploader.filename, gadget_id: @gadget.id)
    create_size(image)
  end

  def resize
    image = Image.find(params[:id])
    create_size(image)

    render :create
  end

  private
    def create_size(image)
      @image_size = V1::ImageSizePresenter.new(image.create_size(params[:width], params[:height]), view_context)
    end
end
