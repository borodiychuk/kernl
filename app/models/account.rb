class Account < ActiveRecord::Base

  has_many :users,       :dependent => :destroy
  has_many :storages,    :dependent => :destroy
  has_many :entries, :through => :storages
  has_many :fields,  :through => :storages
  has_many :values,  :through => :fields

  validates_presence_of :name
  validates_presence_of :email

end
