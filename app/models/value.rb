class Value < ActiveRecord::Base

  belongs_to :field
  belongs_to :entry
  has_many :attachments, :dependent => :destroy
  # Only for connected entries, otherwise it will not let create two abandoned values
  validates_uniqueness_of :field_id, :scope => :entry_id, :if => :entry_id

  default_scope -> () { order "field_id ASC" } # This lets cache queries much effectively
  scope :of_field, ->(f) { where(:field => f) }
  scope :of_entry, ->(e) { where(:entry => e) }
  scope :unassigned, ->() { where(:entry => nil) }
  scope :abandoned,  ->() { unassigned.where("values.created_at < ?", DateTime.now - 1.day) }

  def exposed_value
    field.expose self
  end


  ##
  ##  Touchable logic
  ##

  include AsyncTouchable
  include ChainToucher

  def chain_touch_callback
    entry.touch! if entry
  end

end
