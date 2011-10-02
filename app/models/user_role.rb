class UserRole < ActiveRecord::Base
  has_many :users,
    :dependent => :nullify,
    :foreign_key => :role_id,
    :inverse_of => :role


  def symbols
    [name.to_sym]
  end
end
