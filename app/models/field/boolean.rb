class Field::Boolean < Field

  protected

  def normalize value
    !!value
  end

end
