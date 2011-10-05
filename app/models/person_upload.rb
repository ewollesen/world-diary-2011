class PersonUpload < ActiveRecord::Base
  belongs_to :person, :inverse_of => :uploads

  mount_uploader :upload, UploadUploader

  validates :person, :presence => true

  attr_accessible :caption, :private, :upload, :upload_cache


  def caption
    cap = read_attribute(:caption)
    cap.blank? ? File.basename(url) : cap
  end

  def method_missing(name, *args)
    if upload.respond_to?(name)
      upload.send(name, *args)
    else
      super
    end
  end
end
