class Storage < ActiveRecord::Base

  belongs_to :account
  has_many :entries, :dependent => :destroy
  has_many :fields,  :dependent => :destroy

  def entry_accessible_attributes
    fields.pluck(:identifier).map(&:to_sym)
  end

  def backend_list_fields
    fields.backend_list_listed
  end


  ##
  ##  Touchable logic
  ##

  include AsyncTouchable

end
