class Gadget
  include MongoMapper::Document

  key :token, String

  many :images

  def self.generate_token
    loop do
      token = SecureRandom.base64(64)
      unless Gadget.find_by_token(token)
        break token
      end
    end
  end
end
