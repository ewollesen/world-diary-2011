class WdMarkdown < Redcarpet::Render::XHTML

  def preprocess(document)
    temp = document.gsub(/(?<!\\)\^(.*?(?<!\\))\^/, "<span title=\"DM-only text\" class=\"dm\">\\1</span>")
    temp = temp.gsub(/\\\^/, "^")
    temp = temp.gsub(/(?<!\\)%(.*?(?<!\\))%/, "<span title=\"VP-holder text\" class=\"vp\">\\1</span>")
    temp = temp.gsub(/\\%/, "%")
  end

  def block_code(code, language)
    class_, title = case language
                    when /dm/i
                      ["dm", "DM-only text"]
                    when /vp/i
                      ["vp", "VP-holder text"]
                    else
                      [nil, nil]
                    end

    if class_
      "<p title=\"#{title}\" class=\"#{class_}\">\n#{code} (#{class_})\n</p>"
    else
      code
    end
  end

end
