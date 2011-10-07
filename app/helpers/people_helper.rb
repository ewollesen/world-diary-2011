module PeopleHelper

  def class_for_upload(upload)
    if upload.visible_with_vp
      "vp"
    elsif upload.private
      "dm"
    else
      ""
    end
  end
end
