require 'fileutils'

module Pathes
  extend ActiveSupport::Concern

  attr_accessor :filename

  UPLOAD_PATH = "/private/files"
  IMAGE_SIZES_PATH = "/images";

  def public_file_path(width, height)
    new_path = Rails.root.to_s + '/public' + IMAGE_SIZES_PATH + '/' + path_for_file(filename)

    unless File.directory?(new_path)
      FileUtils.mkdir_p(new_path)
    end

    new_path + "/" + File.basename(filename, ".*") + "_#{width}_x_#{height}" + File.extname(filename)
  end

  def private_file_path(include_filename = false)
    path = Rails.root.to_s + UPLOAD_PATH + '/' + path_for_file(filename)

    if include_filename
      path + '/' + filename
    else
      path
    end
  end

  def link_path(width, height)
    IMAGE_SIZES_PATH + '/' + path_for_file(filename) + '/' + File.basename(filename, ".*").to_s + "_#{width}_x_#{height}" + File.extname(filename).to_s
  end

  private
    def path_for_file(filename)
      filename[0..1] + "/" + filename[2..3]
    end
end