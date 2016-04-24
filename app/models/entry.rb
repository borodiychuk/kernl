class Entry < ActiveRecord::Base

  belongs_to :storage
  has_many   :values, :dependent => :destroy
  has_many   :fields, :through => :storage

  scope :published, ->() { where :enabled => true }


  # Override basic ActiveRecord stuff
  def update_attributes! params
    super ActionController::Parameters.new(params).permit(:enabled)
    storage.fields.each do |f|
      f.store! params[f.identifier], self
    end
  end

  def as_json params = {}
    result = attributes
    values.each do |v|
      result[v.field.identifier] = v.exposed_value
    end
    result
  end

end
