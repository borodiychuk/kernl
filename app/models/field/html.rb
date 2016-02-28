class Field::Html < Field

  protected

  def normalize value
    value.to_s if value
  end

end
