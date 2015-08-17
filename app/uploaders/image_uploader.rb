class ImageUploader < CarrierWave::Uploader::Base
  include Pathes

  # Choose what kind of storage to use for this uploader:
  storage :file

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    private_file_path
  end

  def filename
    if @uniq_name
      @uniq_name
    else
      @uniq_name = "#{SecureRandom.uuid}.#{file.extension}"
    end
  end
end
