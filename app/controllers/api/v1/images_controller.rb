class Api::V1::ImagesController < Api::V1::BaseController
  def index
    @images = @gadget.images.limit(params[:limit] || Image::DEFAULT_LIMIT).offset(params[:offset])
  end

  def create
    process_image do |image_size|
      uploader = ImageUploader.new
      uploader.store! params[:file]

      create_size(Image.new(filename: uploader.filename, gadget_id: @gadget.id), image_size)
    end
  end

  def resize
    return api_error errors: ApiError.new(t("errors.image_access")) unless image = get_image

    process_image do |image_size|
      create_size image, image_size
      render :create
    end
  end

  def create_size(image, image_size)
    @image_size = Api::V1::ImageSizePresenter.new(image.create_size(image_size), view_context)
  end

  private
    def image_size_params
      { width: params[:width], height: params[:height] }
    end

    def get_image
      Image.find_by_id_and_gadget_id(params[:id], @gadget.id)
    end

    def process_image(&block)
      image_size = ImageSize.new(image_size_params)

      if image_size.valid?
        yield image_size if block_given?
      else
        api_error errors: ApiError.new(image_size.errors.messages)
      end
    end
end