class ReportMailer < ActionMailer::Base
  default from: "ravi@alchemistaccelerator.com"

  def send_report_email(scrap, file)
    @scrap = scrap
    
    attachments["report.csv"] = file
    mail(:to => "#{@scrap.email}", :bcc => "kalpeshdave@foundershookup.com",
          :subject => "Requested Generated Report via Alchemist Accelerator")
  end

  def error_email(scrap, error)
    @scrap = scrap
    @error = error
    mail(:to => "kalpeshdave@foundershookup.com", :bcc => "kalpeshdave@foundershookup.com",
          :subject => "Error while Customer Generating Report via Alchemist Accelerator")
  end

  def failure_email(scrap)
    @scrap = scrap
    mail(:to => "kalpeshdave@foundershookup.com", :bcc => "kalpeshdave@foundershookup.com",
          :subject => "Requested Generated Report Failure via Alchemist Accelerator")
  end
  
end
