class Project < ActiveRecord::Base

  belongs_to :account
  has_many :products
  has_many :field_files

end
