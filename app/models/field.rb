class Field < ActiveRecord::Base

  belongs_to :storage
  has_many   :values, :dependent => :destroy

  scope :backend_list_listed, ->() { where(:shown_in_backend_list => true) }

  def content_type
    type.underscore.split("/").last.to_sym
  end

  def store! value, entry
    v = values.of_entry(entry).first_or_initialize
    v.update_attribute :data, { "value" => normalize(value) }
  end

  def expose value
    value.data["value"] if value && value.data
  end

  protected

  def normalize value
    value
  end


end
