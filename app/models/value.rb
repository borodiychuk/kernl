class Value < ActiveRecord::Base

  belongs_to :field
  belongs_to :entry
  has_many :attachments, :dependent => :destroy
  validates_uniqueness_of :field_id, :scope => :entry_id

  default_scope -> () { order "field_id ASC" } # This lets cache queries much effectively
  scope :of_field, ->(f) { where(:field => f) }
  scope :of_entry, ->(e) { where(:entry => e) }
  scope :unassigned, ->() { where(:entry => nil) }
  scope :abandoned,  ->() { unassigned.where("values.created_at < ?", DateTime.now - 1.day) }

  def exposed_value
    field.expose self
  end

end
