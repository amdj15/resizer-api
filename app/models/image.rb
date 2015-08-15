class Image
  include MongoMapper::Document
  include Pathes

  # key :name, String

  belongs_to :gadget
  many :image_sizes

  def create_size(width, height)
    image_size = ImageSize.new(width: width, height: height, image: self)

    file = MiniMagick::Image.open(pivate_file_path(filename, true))
    file.resize "#{width}x#{height}"
    file.write public_file_path(width, height)

    self.image_sizes << image_size

    image_size
  end
end
