module ApplicationHelper

  def title(title)
    content_for(:title, title)
  end

  def keywords(&block)
    content = replace_quotes(capture(&block)).strip
    content_for(:meta) do
      tag("meta", :name => "keywords", :content => content) + "\n"
    end
  end

  def description(&block)
    content = replace_quotes(capture(&block)).strip
    content_for(:meta) do
      tag("meta", :name => "description", :content => content) + "\n"
    end
  end

  def date(date)
    case date
    when Date
      date = date.to_s(:iso8601)
    when Time
      date = date.utc.to_s(:iso8601)
    end
    content_for(:meta) {tag("meta", :name => "date", :content => date) + "\n"}
  end

  def noindex
    content_for(:meta) do
      tag("meta", :name => "robots", :content => "noindex") + "\n"
    end
  end

  def render_flash
    content_tag("div", :id => "flash_wrapper") do
      flash.inject("") do |ret, (key, value)|
        ret << content_tag("div", :class => "flash #{key}") do
          image_tag("flash_close.png", :title => "Close", :class => "close") +
            h(value) +
            image_tag("flash_#{key}.png", :class => key)
        end
      end.html_safe
    end
  end

  def obscure_email(email)
    return nil if email.nil?
    lower = ('a'..'z').to_a
    upper = ('A'..'Z').to_a
    h(email.gsub(/@/, " at ").gsub(/\./, " dot ")).split('').map do |char|
      output = lower.index(char) + 97 if lower.include?(char)
      output = upper.index(char) + 65 if upper.include?(char)
      output ? "&##{output};" : (char == '@' ? '&#0064;' : char)
    end.join.html_safe
  end


  protected

  def replace_quotes(text)
    text.gsub(/"/, "&#34;").gsub(/'/, "&#39;")
  end

end
