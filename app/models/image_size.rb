class ImageSize
  include MongoMapper::Document

  key :height, Integer
  key :width, Integer

  belongs_to :image
end
