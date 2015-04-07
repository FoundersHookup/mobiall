require 'nokogiri'
require 'mechanize'
require 'restclient'
require 'csv'

class ReportMailingJob < Struct.new(:scrap)
  def perform
    @scrap = scrap
    mechanize = Mechanize.new do |agent|
      agent.user_agent_alias = (Mechanize::AGENT_ALIASES.keys - ['Mechanize']).sample
    end
    puts "Performing ..."
    if @scrap.url == "alumni.mckinsey.com"
      page = mechanize.get('https://alumni.mckinsey.com/')
      login_form = page.forms.first
      login_form['login_id'] = "29310"
      login_form['password'] = "McK1nsey"

      loggedin_page = login_form.submit

      search_form = loggedin_page.forms.second

      search_form['keywords'] = @scrap.keyword.chomp

      result_page = search_form.submit

      total_result = result_page.search("#action_head").at('.left')

      unless total_result.text.scan(/\d+/).last.nil?
        @scrap.result = total_result.text.scan(/\d+/).last

        people = result_page.search("div[class='member clearfix']")
        @file = CSV.generate do |csv|
          csv << ["Name", "Email", "Member Type", "Title", "Company", "City"]
          people.each do |person|
            next if person.at("div[class='full_name'] a").blank?
            full_name = person.at("div[class='full_name'] a").try(:text)
            type = person.at("div[class='full_name']").at("span[class='member_type alumni']").try(:text)
            title = person.at("div span[class='title']").try(:text)
            company = person.at("div span[class='company'] a").try(:text)
            location = person.at("div[class='year_office']").try(:text)

            uri = person.at("div[class='full_name'] a")["href"]
            alumn_detail_page = mechanize.get("https://alumni.mckinsey.com#{uri}")
            alumn_email = alumn_detail_page.search("div.preferred_email").at("span a").text rescue ""
            csv << [full_name, alumn_email, type, title, company, location]
          end
        end
      end
    elsif @scrap.url == "alumni.hbs.edu"
      page = mechanize.get("https://www.alumni.hbs.edu/community/Pages/directory-search.aspx?q=#{@scrap.keyword}&isHomeSearch=Yes#searchRefreshAnchor")
      login_form = page.forms.first

      login_form['username'] = "rbelani@mba2006.hbs.edu"
      login_form['password'] = "Nrlife123"

      result_page = login_form.submit

      total_result = result_page.search("#resultsNum").text.scan(/\d+/).first
      @scrap.result = total_result

      unless total_result.eql?("0")
        search_result = result_page.search("#search-results")


        @file = CSV.generate do |csv|
          csv << ["Full Name", "Title", "Company", "City", "Email", "Contact Number"]
          search_result.css("div.row div.span6 ul li").each do |row|
            name = row.css("div.results-mobile div.span5 span.mu-uc a").text
            city = row.css("div.results-mobile div.span5 span.mu-uc span.ash").text

            prof_desc = row.css("div.results-mobile div.span5 div.nu").text
            unless prof_desc.blank?
              title = row.css("div.results-mobile div.span5 div.nu").text.split(",")[0]
              company = row.css("div.results-mobile div.span5 div.nu").text.split(",")[1].strip
            else
              title, company = "", ""
            end
            unless row.css("div.results-mobile div.span5 div.row div.if-alumni a").empty?
            alumni_id = row.css("div.results-mobile div.span5 div.row div.if-alumni a").first["id"]
            alumn_detail_page = mechanize.get("https://www.alumni.hbs.edu/community/Pages/view-profile.aspx?alumId=#{alumni_id}")
            alumn_email = alumn_detail_page.parser.css("a.profile-email-link").first.text rescue nil
            if alumn_email.nil?
              alumn_contact = [nil, nil, nil]
            else
              alumn_contact = []
              alumn_detail_page.parser.css("div#profile div.row div.span7 div.row div.col2 div").each{|i| alumn_contact << i.text rescue ""}
            end
            else
              alumn_email = nil
              alumn_contact = [nil, nil, nil]
            end

            csv << [name, title, company, city, alumn_email, "#{alumn_contact[1]} / #{alumn_contact[1]}"]
          end
        end
      end
    end
    puts "Performed"
  end


  def success(job)
    @scrap.save
    ReportMailer.send_report_email(@scrap, @file).deliver!
    puts "Success"
  end

  def error(job, exception)
    ReportMailer.error_email(@scrap, exception, job.last_error).deliver!
    puts "Error"
  end

  def failure(job)
    ReportMailer.failure_email(@scrap, job.last_error).deliver!
    puts "Failure"
  end

#  def max_attempts
#    1
#  end
end
