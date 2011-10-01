module LinkHelper

  def linkify(text)
    return text if text.blank?

    text.gsub(LINK_RE) do |match|
      text = $1
      class_obj, class_name = class_info_from_name_or_abbreviation($2)
      name = $3.strip
      title = $4 || ((text.blank? || (name == text)) ? nil : name)
      obj = class_obj.find_by_name(name.gsub(/\s+/, " "))

      if obj
        url = send("#{class_name}_url", obj)
        "[%s](%s%s)" % [text || obj.name, url, title ? " \"#{title}\"" : nil]
      else
        url = send("new_#{class_name}_url", "#{class_name}" => {:name => name})
        "[%s](%s#new)" % [text || name, url]
      end
    end
  end


  private

  PLACE_RE = /(?:pl(?:aces?)?)/i
  PERSON_RE = /(?:pe(?:rson|ople)?)/i
  ORGANIZATION_RE = /(?:o(?:rganizations?)?)/i
  NOTE_RE = /(?:n(?:otes?)?)/i
  LINK_RE = /(?:\[([^\]]+)\])?\((#{PLACE_RE.source}|#{PERSON_RE.source}|#{ORGANIZATION_RE.source}|#{NOTE_RE.source}):([^\"\)]+)(?:\s?"([^\"]+)")?\)/i

  def class_info_from_name_or_abbreviation(name_or_abbreviation)
    case name_or_abbreviation
    when /^o/i
      [@campaign.send("organizations"), "organization"]
    when /^pe/i
      [@campaign.send("people"), "person"]
    when /^pl/i
      [@campaign.send("places"), "place"]
    when /^t/i
      [@campaign.send("things"), "thing"]
    else
      [@campaign.send(name_or_abbreviation.pluralize.underscore),
       name_or_abbreviation.underscore.downcase]
    end
  end

end
