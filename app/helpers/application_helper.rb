# -*- coding: utf-8 -*-
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

  def append_private_icon(object, content, &block)
    content = capture(&block) if block_given?
    content.html_safe + " " + private_icon(object)
  end

  def private_icon(object)
    return "" unless object.private
    image_tag("lock.png", alt: "Closed padlock", title: "Private").html_safe
  end

  def private_upload_icon(object)
    return unless object.private
    content_tag("span", private_icon(object), class: "overlay_wrap")
  end

  def see_all_link(scope, term)
    "See all #{pluralize(scope.with_permissions_to(:read).count, term)}.".html_safe
  end

  def description(text)
    step1 = highlight(markdown(linkify(text)), params[:q])
    return step1 if is_dm?
    step2 = strip_dm(step1)
    return step2 if visible_due_to_veil_pass?(@person) # FIXME
    step3 = strip_vp(step2)
  end

  def markdown(text)
    @renderer ||= WdMarkdown.new(with_toc_data: true)
    @markdown ||= Redcarpet::Markdown.new(@renderer, tables: true, :fenced_code_blocks => true)
    @markdown.render(h(text)).html_safe
  end

  def is_dm?
    return false unless user_signed_in?
    current_user.campaign_ids.include?(current_campaign.id)
  end

  def visible_due_to_veil_pass?(subject)
    subject.private && current_user.has_veil_pass_for?(subject)
  end

  def highlight(text, phrases, *args)
    options = args.extract_options!
    args << "<span class=\"highlight\">\\1</span>" if args.empty?
    super(text, phrases, *(args << options))
  end


  protected

  def strip_dm(text)
    dm_xslt =<<EOF
<?xml version='1.0' encoding='utf-8' ?>
<xsl:stylesheet version='1.0' xmlns:xsl='http://www.w3.org/1999/XSL/Transform'>

  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match='//*[@class="dm"]' />
</xsl:stylesheet>
EOF
    xslt = Nokogiri::XSLT(dm_xslt)
    doc = Nokogiri::XML("<div>" + text + "</div>")
    transformed = xslt.transform(doc)
    transformed.to_html.html_safe
  end

  def strip_vp(text)
    vp_xslt =<<EOF
<?xml version='1.0' encoding='utf-8' ?>
<xsl:stylesheet version='1.0' xmlns:xsl='http://www.w3.org/1999/XSL/Transform'>

  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match='//*[@class="vp"]' />
</xsl:stylesheet>
EOF
    xslt = Nokogiri::XSLT(vp_xslt)
    doc = Nokogiri::XML("<div>" + text + "</div>")
    transformed = xslt.transform(doc)
    transformed.to_html.html_safe
  end

  def replace_quotes(text)
    text.gsub(/"/, "&#34;").gsub(/'/, "&#39;")
  end

end
