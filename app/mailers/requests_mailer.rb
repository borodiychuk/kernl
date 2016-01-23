class RequestsMailer < ActionMailer::Base
  default :from => "Kernl <today@kernl.rocks>", :bcc => "kernl.bcc@markusweb.com, kernl.bcc@fetz.cc"

  def inquiry data
    @account         = data[:account]
    @project         = data[:project]
    @product         = data[:product]
    @product_variant = data[:product_variant]
    @message         = data[:message]
    mail :subject => "#{@project.name} Anfrage", :to => @account.email
  end

end
