class User < ActiveRecord::Base
  devise :database_authenticatable, :rememberable, :trackable
  include DeviseTokenAuth::Concerns::User

  validates_presence_of :email

  belongs_to :account

  #####################################################
  ##
  ##  Auth stuff logic
  ##
  #####################################################

  def password_confirmation_needed
    !encrypted_password.empty?
  end

end
