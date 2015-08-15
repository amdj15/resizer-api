require 'fileutils'

module Pathes
  extend ActiveSupport::Concern

  UPLOAD_PATH = "/private/files"
  IMAGE_SIZES_PATH = "/images";

  def public_file_path(width, height)
    new_path = Rails.root.to_s + '/public' + IMAGE_SIZES_PATH + '/' + path_for_file(filename)

    unless File.directory?(new_path)
      FileUtils.mkdir_p(new_path)
    end

    new_path + "/" + File.basename(filename, ".*") + "_#{width}_x_#{height}" + File.extname(filename)
  end

  def pivate_file_path(filename, with_file = false)
    path = Rails.root.to_s + UPLOAD_PATH + '/' + path_for_file(filename)

    if with_file
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
      filename[0..1] + "/" + filename[1..2]
    end
end