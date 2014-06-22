class UserMailer < ActionMailer::Base
  default :from => "gcthuan@apcs.vn"
  def send_package(user)
  	@user = user
  	mail(:to => user.email, :subject => "registration")
  end
end
