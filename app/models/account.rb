class Account < ActiveRecord::Base

  has_many :users
  has_many :projects
  has_many :products, :through => :projects

  validates_presence_of :name
  validates_presence_of :email

end
