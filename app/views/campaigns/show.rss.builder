xml.instruct!(:xml, :version => "1.0")
xml.rss(:version => "2.0") do
  xml.channel do
    xml.title("World Diary : #{current_campaign.name}")
    xml.language("en-us")
    xml.ttl(1.day / 1.minute) # 1 day, in minutes
    xml.link(campaign_url(current_campaign))
    xml.lastBuildDate(current_campaign.updated_at.strftime("%a, %d %b %Y"))
    current_campaign.visible_people.order("people.updated_at DESC").each do |object|
      xml.item do
        xml.title(object.name)
        xml.description(markdown(linkify(object.description)))
        xml.pubDate(object.updated_at.strftime("%a, %d %b %Y"))
        xml.link(polymorphic_url(object))
      end
    end
  end
end