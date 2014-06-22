ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
:address => "smtp.gmail.com",
:port => 587,
:domain => "gmail.com",
:user_name => "gcthuan@apcs.vn",
:password => "altair011712",
:authentication => "plain",
:enable_starttls_auto => true
}