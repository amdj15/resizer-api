class V1::ImagesController < V1::BaseController
  def index
    @images = @gadget.images
  end

  def create
    uploader = ImageUploader.new
    uploader.store! params[:file]

    image = Image.create!(filename: uploader.filename, gadget_id: @gadget.id)
    image_size = image.create_size(params[:width], params[:height])

    @image_size = V1::ImagePresenter.new(image_size, view_context)
  end
end
