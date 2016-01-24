class RequestsMailer < ActionMailer::Base
  default :from => "Kernl <today@kernl.rocks>", :bcc => "kernl.bcc@markusweb.com, kernl.bcc@fetz.cc"

  def inquiry data
    @data = data
    mail :subject => "#{@data[:project].name} Anfrage", :to => @data[:project].account.email
  end

end
