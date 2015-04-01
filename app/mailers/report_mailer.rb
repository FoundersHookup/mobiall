class ReportMailer < ActionMailer::Base
  default from: "ravi@alchemistaccelerator.com"

  def send_report_email(scrap, file)
    @scrap = scrap
    
    attachments["report.csv"] = file
    mail(:to => "#{@scrap.email}", :bcc => "kalpeshdave@foundershookup.com",
          :subject => "Requested Generated Report From [#{@scrap.url}]")
  end

  def error_email(scrap, error, log)
    @scrap = scrap
    @error = error
    @log = log
    mail(:to => "kalpeshdave@foundershookup.com", :bcc => "kalpeshdave@foundershookup.com",
          :subject => "Error while Customer Generating Report via Alchemist Accelerator")
  end

  def failure_email(scrap, error)
    @scrap = scrap
    @error = error
    mail(:to => "kalpeshdave@foundershookup.com", :bcc => "kalpeshdave@foundershookup.com",
          :subject => "Requested Generated Report Failure via Alchemist Accelerator")
  end
  
end
