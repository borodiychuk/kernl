class Account < ActiveRecord::Base

  has_many :users
  has_many :projects
  has_many :products, :through => :projects

end
