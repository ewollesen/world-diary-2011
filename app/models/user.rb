class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable,
  # :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :campaigns,
    :dependent => :nullify,
    :foreign_key => "dm_id",
    :inverse_of => :dm
  belongs_to :role, :inverse_of => :users, :class_name => "UserRole"

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name
  validates :name, :presence => true, :uniqueness => true


  def role_symbols
    role ? role.symbols : [:user]
  end
end
