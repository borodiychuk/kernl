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
      # We do it inside values because we have already queued them
      # Otherwise optimization (show less data) may lead into a complication (extra query per each entry)
      result[v.field.identifier] = v.exposed_value if params[:only].blank? || params[:only].include?(v.field.identifier.to_sym)
    end
    result
  end


  ##
  ##  Touchable logic
  ##

  include AsyncTouchable
  include ChainToucher

  def chain_touch_callback
    storage.touch!
  end


end
