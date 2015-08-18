class ImageSize
  include MongoMapper::EmbeddedDocument
  include ActiveModel::Validations

  key :height, Integer
  key :width, Integer

  embedded_in :image

  validates :height, :width, presence: true, numericality: { only_integer: true }
end
