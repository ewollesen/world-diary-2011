module CampaignsHelper

  def campaign_description(campaign)
    desc = campaign.description || "No description."
    text = linkify(desc)
    Haml::Filters::Markdown.render(text).html_safe
  end

end
