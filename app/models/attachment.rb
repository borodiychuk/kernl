class Attachment < ActiveRecord::Base

  belongs_to :value

  dragonfly_accessor :file

  default_scope ->() { order("ordering ASC")}
  scope :unassigned, ->() { where(:object_id => nil) }

  after_create do |a|
    a.update_attribute :ordering, a.id if a.ordering.nil?
  end

  def file_url
    file.remote_url
  end

  def file_small_url
    thumbnailable? ? file.thumb('600x600>').url : placeholder_thumbnail
  end

  def file_large_url
    thumbnailable? ? file.thumb('980x').url : placeholder_thumbnail
  end

  def file_thumbnail_url
    thumbnailable? ? file.thumb('100x100#').url : placeholder_thumbnail
  end

  private

  def thumbnailable?
    file && %w(.jpg .jpeg .png .gif).include?(File.extname(file.name).downcase)
  end

  def placeholder_thumbnail
    ActionController::Base.helpers.asset_url "placeholder.png"
  end

end
