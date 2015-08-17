class Image
  include MongoMapper::Document
  include Pathes

  DEFAULT_LIMIT = 25

  belongs_to :gadget
  many :image_sizes

  key :filename, String

  validates :filename, presence: true

  def create_size(image_size)
    image_size.image = self

    resize_file(image_size)
    self.image_sizes << image_size

    image_size
  end

  private
    def resize_file(image_size)
      file = MiniMagick::Image.open(private_file_path(true))
      file.resize "#{image_size.width}x#{image_size.height}"
      file.write public_file_path(image_size.width, image_size.height)
    end
end
