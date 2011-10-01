# encoding: utf-8

class UploadUploader < CarrierWave::Uploader::Base
  include ActionView::Helpers::AssetTagHelper
  include CarrierWave::RMagick

  storage :file

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url
    "/assets/fallback/" + [version_name, "default.png"].compact.join('_')
  end


  process :fix_exif_rotation, :if => :file_is_image?


  version "sidebar", :if => :file_is_image? do
    process :resize_to_fill => [230, 230]
  end

  version "thumb", :if => :file_is_image? do
    process :resize_to_fill => [110, 110]
  end

  def display_url
    image?(url) ? url : default_url
  end

  def file_is_image?(file)
    image?(file.filename)
  end

  def image?(filename)
    ext = File.extname(filename)
    case ext
    when /jpe?g/i, /png/i, /gif/i, /bmp/i
      true
    else
      false
    end
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # def extension_white_list
  #   %w(jpg jpeg gif png)
  # end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end
