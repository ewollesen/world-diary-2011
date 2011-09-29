class Person < ActiveRecord::Base
  belongs_to :campaign, :inverse_of => :people

  validates :name, :presence => true, :uniqueness => {:scope => :campaign_id}
  validates :campaign, :presence => true
end
