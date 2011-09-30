module CarrierWave
  module RMagick

    # Rotates the image based on the EXIF Orientation
    # https://gist.github.com/965983
    def fix_exif_rotation
      manipulate! do |img|
        img.auto_orient!
        img = yield(img) if block_given?
        img
      end
    end

  end
end
