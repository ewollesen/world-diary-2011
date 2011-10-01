class Campaign < ActiveRecord::Base
  belongs_to :dm,
    :class_name => "User",
    :foreign_key => "dm_id",
    :inverse_of => :campaigns
  has_many :people, :inverse_of => :campaign, :dependent => :destroy

  validates :name, :presence => true, :uniqueness => {:scope => :dm_id}
  validates :dm, :presence => true

  delegate :name, :to => :dm, :prefix => true

  attr_accessible :name, :description


  def self.recently_updated(num=5)
    order("updated_at DESC").limit(num)
  end
end
