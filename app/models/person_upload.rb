class PersonUpload < ActiveRecord::Base
  belongs_to :person, :inverse_of => :uploads

  mount_uploader :upload, UploadUploader

  validates :person, :presence => true
end
