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
  has_many :person_veil_passes, :inverse_of => :user, :dependent => :destroy do
    def people_ids
      all.map(&:person_id)
    end
  end

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name
  validates :name, :presence => true, :uniqueness => true


  def role_symbols
    role ? role.symbols : [:user]
  end

  def has_veil_pass_for?(object)
    object.veil_passes.users_ids.include?(id)
  end
end
