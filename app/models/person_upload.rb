class PersonUpload < ActiveRecord::Base
  belongs_to :person, :inverse_of => :uploads

  mount_uploader :upload, UploadUploader

  validates :person, :presence => true


  def method_missing(name, *args)
    if upload.respond_to?(name)
      upload.send(name, *args)
    else
      super
    end
  end
end
