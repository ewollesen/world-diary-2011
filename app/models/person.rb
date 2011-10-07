class Person < ActiveRecord::Base
  include PgSearch

  belongs_to :campaign, :inverse_of => :people, :touch => true
  has_one :dm, :through => :campaign
  has_many :uploads,
    :class_name => "PersonUpload",
    :dependent => :destroy,
    :inverse_of => :person
  has_many :veil_passes,
    :class_name => "PersonVeilPass",
    :dependent => :destroy,
    :inverse_of => :person do
    def users_ids
      all.map(&:user_id)
    end
  end

  pg_search_scope :full_search, {
    :against => {:name => "A", :public_description => "B",},
    :using => {
      :tsearch => {:prefix => true,},
    },
  }

  validates :name, :presence => true, :uniqueness => {:scope => :campaign_id}
  validates :campaign, :presence => true

  accepts_nested_attributes_for :uploads,
    :allow_destroy => true,
    :reject_if => proc {|attr| attr["id"].blank? && attr["upload"].blank? && attr["upload_cache"].blank?}
  accepts_nested_attributes_for :veil_passes,
    :allow_destroy => true,
    :reject_if => proc {|attr| attr["id"].blank? && (attr["person_id"].blank? || attr["user_id"].blank?)}

  attr_accessible :name,
                  :description,
                  :private,
                  :uploads_attributes,
                  :veil_passes_attributes

  has_paper_trail :on => [:update,], :ignore => [:private,]

  before_save :update_public_description


  def self.recently_updated(num=5)
    order("people.created_at DESC").limit(num)
  end


  def visible_uploads
    uploads.with_permissions_to(:read).order("person_uploads.created_at")
  end


  private

  def update_public_description
    if description_changed?
      self.public_description = description_with_dm_and_vp_removed
    end
  end

  def description_with_dm_and_vp_removed
    public_xslt =<<EOF
<?xml version='1.0' encoding='utf-8' ?>
<xsl:stylesheet version='1.0' xmlns:xsl='http://www.w3.org/1999/XSL/Transform'>

  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match='//*[@class="dm"]' />
  <xsl:template match='//*[@class="vp"]' />
</xsl:stylesheet>
EOF
    renderer = WdMarkdown.new(with_toc_data: true)
    markdown = Redcarpet::Markdown.new(renderer, tables: true, fenced_code_blocks: true)
    safe = markdown.render(ERB::Util.h(description))

    xslt = Nokogiri::XSLT(public_xslt)
    doc = Nokogiri::XML("<div>" + safe + "</div>")
    transformed = xslt.transform(doc)
    transformed.to_html.html_safe
  end

end
