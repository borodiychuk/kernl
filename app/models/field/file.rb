class Field::File < Field

  def store! value, entry
    # Normally value should be blank. But once it given, we consider we assign a previously prepared dataset
    return if value.blank?
    value = values.unassigned.find(value)
    value.update_attributes! :data => nil, :entry => entry
  end

  def expose value
    value.attachments.as_json(
      :methods => [:file_url, :file_small_url, :file_large_url, :file_thumbnail_url]
    )
  end

end
