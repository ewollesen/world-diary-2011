module CampaignsHelper

  def campaign_description(desc)
    desc ||= "No description."
    text = linkify(desc)
    BlueCloth.new(text).to_html.html_safe
  end

end
