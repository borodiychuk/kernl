class Field::Text < Field

  protected

  def normalize value
    value.to_s if value
  end

end
