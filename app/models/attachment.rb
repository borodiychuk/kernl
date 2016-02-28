class Attachment < ActiveRecord::Base

  belongs_to :value

  dragonfly_accessor :file

  default_scope ->() { order("ordering ASC")}
  scope :unassigned, ->() { where(:object_id => nil) }

  def file_url
    file.remote_url if file
  end

  def file_small_url
    file.thumb('600x600>').url if file
  end

  def file_large_url
    file.thumb('980x').url if file
  end

  def file_thumbnail_url
    file.thumb('100x100#').url if file
  end

end
