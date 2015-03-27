#require 'development_mail_interceptor'

ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 25,
  :domain               => "gmail.com",
  :user_name            => "ravi@alchemistaccelerator.com",
  :password             => "nrlife123",
  :authentication       => :plain,
  :enable_starttls_auto => true
}

#Mail.register_interceptor(DevelopmentMailInterceptor) if Rails.env.development?