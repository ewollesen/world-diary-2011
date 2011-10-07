class PersonVeilPass < ActiveRecord::Base
  belongs_to :person, :inverse_of => :veil_passes
  belongs_to :user, :inverse_of => :person_veil_passes

  validates :user, :presence => true
  validates :person, :presence => true
  validates :user_id, :uniqueness => {:scope => :person_id}

  attr_accessible :person_id, :user_id

  delegate :name, :to => :user, :prefix => true
end
