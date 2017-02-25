class Field < ActiveRecord::Base

  belongs_to :storage
  has_many   :values, :dependent => :destroy

  default_scope ->() { order "ordering ASC" }

  scope :backend_list_listed, ->() { where(:shown_in_backend_list => true) }

  #attr_accessor :content_type

  def content_type
    type.underscore.split("/").last.to_sym
  end

  def content_type= value
    self[:type] = "field/#{value}".camelize
  end

  def store! value, entry
    v = values.of_entry(entry).first_or_initialize
    v.update_attribute :data, { "value" => normalize(value) }
  end

  def expose value
    value.data["value"] if value && value.data
  end


  ##
  ##  Touchable logic
  ##

  # TODO: somehow it throws error on including a concern, so I need to put its content here
  after_create  :chain_touch_callback
  after_save    :chain_touch_callback
  after_destroy :chain_touch_callback
  after_touch   :chain_touch_callback

  def chain_touch_callback
    storage.touch!
  end


  protected

  def normalize value
    value
  end


end
