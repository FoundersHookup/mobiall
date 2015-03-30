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
      login_form['login_id'] = "rbelani"
      login_form['password'] = "Nrlife123"

      loggedin_page = login_form.submit

      search_form = loggedin_page.forms.second

      search_form['keywords'] = @scrap.keyword

      result_page = search_form.submit

      total_result = result_page.search("#action_head").at('.left')

      unless total_result.text.scan(/\d+/).first.nil?
        @scrape.result = total_result.text.scan(/\d+/).first

        people = result_page.search("div[class='member clearfix']")
        @file = CSV.generate do |csv|
          csv << ["Name", "Member Type", "Title", "Company", "City"]
          people.each do |person|
            full_name = person.at("div[class='full_name'] a").try(:text)
            type = person.at("div[class='full_name']").at("span[class='member_type alumni']").try(:text)
            title = person.at("div span[class='title']").try(:text)
            company = person.at("div span[class='company'] a").try(:text)
            location = person.at("div[class='year_office']").try(:text)
            csv << [full_name, type, title, company, location]
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
          csv << ["Full Name", "Title", "Company", "City"]
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

            csv << [name, title, company, city]
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
    ReportMailer.error_email(@scrap, exception).deliver!
    puts "Error"
  end

  def failure(job)
    ReportMailer.failure_email(@scrap).deliver!
    puts "Failure"
  end
end