class Person < ActiveRecord::Base
  belongs_to :campaign, :inverse_of => :people, :touch => true
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

  validates :name, :presence => true, :uniqueness => {:scope => :campaign_id}
  validates :campaign, :presence => true

  accepts_nested_attributes_for :uploads,
    :allow_destroy => true,
    :reject_if => proc {|attr| attr["id"].blank? && attr["caption"].blank? && attr["upload"].blank?}
  accepts_nested_attributes_for :veil_passes,
    :allow_destroy => true,
    :reject_if => proc {|attr| attr["id"].blank? && (attr["person_id"].blank? || attr["user_id"].blank?)}

  attr_accessible :name,
                  :description,
                  :private,
                  :uploads_attributes,
                  :veil_passes_attributes

  has_paper_trail :on => [:update,]


  def self.recently_updated(num=5)
    order("people.created_at DESC").limit(num)
  end


  def visible_uploads
    uploads.with_permissions_to(:read).order("person_uploads.created_at")
  end
end
