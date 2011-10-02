class Person < ActiveRecord::Base
  belongs_to :campaign, :inverse_of => :people, :touch => true
  has_many :uploads,
    :class_name => "PersonUpload",
    :dependent => :destroy,
    :inverse_of => :person

  validates :name, :presence => true, :uniqueness => {:scope => :campaign_id}
  validates :campaign, :presence => true

  accepts_nested_attributes_for :uploads,
    :allow_destroy => true,
    :reject_if => :all_blank

  attr_accessible :name, :description, :private


  def self.recently_updated(num=5)
    order("people.created_at DESC").limit(num)
  end

end
