class ResourceMailer < ActionMailer::Base
  default from: "ravi@alchemistaccelerator.com"

  def request_email(requested_user)
    @user = requested_user
    @url  = "http://example.com/login"
#    mail(:to => ["#{@user.email}", "#{@user.resource.email}"], :bcc => "ravi.belani@gmail.com, kalpeshdave@foundershookup.com",
    mail(:to => ["#{@user.email}", "#{@user.resource.email}"], :bcc => "",
          :subject => "#{@user.resource.name}, #{@user.company_name} connect via Alchemist Accelerator")
  end

  def feedback_email(feedback)
    @user = feedback
    subject = feedback.is_anonymous? ? "Anonymous Feedback for #{@user.resource.name}" : "Feedback for #{@user.resource.name} from #{@user.name} of #{@user.company_name}"
#    mail(:to => ["#{@user.email}", "#{@user.resource.email}"], :bcc => "ravi.belani@gmail.com, kalpeshdave@foundershookup.com", :subject => subject)
    mail(:to => ["#{@user.resource.email}"], :bcc => "", :subject => subject)
  end
end
