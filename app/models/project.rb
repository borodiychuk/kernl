class Project < ActiveRecord::Base

  belongs_to :account
  has_many :products

end
