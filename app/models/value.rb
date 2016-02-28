class Value < ActiveRecord::Base

  belongs_to :field
  belongs_to :entry
  has_many :attachments, :dependent => :destroy

  scope :of_field, ->(f) { where(:field => f) }
  scope :of_entry, ->(e) { where(:entry => e) }
  scope :unassigned, ->() { where(:entry => nil) }
  scope :abandoned,  ->() { unassigned.where("values.created_at < ?", DateTime.now - 1.day) }

  delegate :exposed_value, :to => :field

  def exposed_value
    field.expose self
  end

end
