class Image
  include MongoMapper::Document
  include Pathes

  belongs_to :gadget
  many :image_sizes

  DEFAULT_LIMIT = 25

  def create_size(image_size)
    image_size.image = self

    file = MiniMagick::Image.open(private_file_path(filename, true))
    file.resize "#{image_size.width}x#{image_size.height}"
    file.write public_file_path(image_size.width, image_size.height)

    self.image_sizes << image_size

    image_size
  end
end
