class NotificationsMailerPreview < ActionMailer::Preview

  def entry_creation
    NotificationsMailer.entry_creation(Entry.all.sample)
  end

end
