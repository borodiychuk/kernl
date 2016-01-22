class Image < ActiveRecord::Base

  belongs_to :product

  dragonfly_accessor :file

  validates_presence_of :file
  validates_presence_of :product

  default_scope ->() { order("ordering ASC")}

  def file_url
    file.remote_url if file
  end

  def file_small_url
    file.thumb('445x200#').url if file
  end

  def file_large_url
    file.thumb('980x').url if file
  end

  def file_thumbnail_url
    file.thumb('100x100#').url if file
  end

end
