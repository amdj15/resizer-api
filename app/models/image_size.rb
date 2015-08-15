class ImageSize
  include MongoMapper::Document

  key :height, Integer
  key :width, Integer

  validates :height, :width, presence: true, numericality: { only_integer: true }

  belongs_to :image
end
