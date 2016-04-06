class Field::Enum < Field

  # TODO: normalize options.dictionary

  protected

  def normalize value
    raise GenericException, "Value out of dictionary" if !value.nil? && !options["dictionary"].map{|v| v["key"]}.include?(value)
    value
  end

end
