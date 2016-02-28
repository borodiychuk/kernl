class Storage < ActiveRecord::Base

  belongs_to :account
  has_many :entries, :dependent => :destroy
  has_many :fields,  :dependent => :destroy

  def entry_accessible_attributes
    [:enabled] + fields.pluck(:identifier).map(&:to_sym)
  end

end
