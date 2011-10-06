module CampaignsHelper

  def campaign_description(desc)
    desc ||= "No description."
    text = markdown(linkify(desc))
  end

end
