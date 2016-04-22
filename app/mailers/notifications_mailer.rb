class NotificationsMailer < ActionMailer::Base
  default :from => "Kernl <today@kernl.rocks>", :bcc => "kernl.bcc@markusweb.com, kernl.bcc@fetz.cc"

  def entry_creation entry
    @entry = entry
    mail :subject => "Neuer Eintrag: #{@entry.storage.name}", :to => @entry.storage.account.email
  end

end
