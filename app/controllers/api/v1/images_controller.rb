class Api::V1::ImagesController < Api::V1::BaseController
  def index
    @images = @gadget.images.limit(params[:limit] || Image::DEFAULT_LIMIT).offset(params[:offset])
  end

  def create
    image_size = ImageSize.new(image_size_params)

    if image_size.valid?
      uploader = ImageUploader.new
      uploader.store! params[:file]

      create_size Image.create!(filename: uploader.filename, gadget_id: @gadget.id), image_size
    else
      api_error errors: image_size.errors
    end
  end

  def resize
    return api_error errors: {error: "Image doesnt exists or belong to another gadget"} unless image = Image.find_by_id_and_gadget_id(params[:id], @gadget.id)

    image_size = ImageSize.new(image_size_params)

    if image_size.valid?
      create_size image, image_size
      render :create
    else
      api_error errors: image_size.errors
    end
  end

  private
    def create_size(image, image_size)
      @image_size = Api::V1::ImageSizePresenter.new(image.create_size(image_size), view_context)
    end

    def image_size_params
      { width: params[:width], height: params[:height] }
    end
end
