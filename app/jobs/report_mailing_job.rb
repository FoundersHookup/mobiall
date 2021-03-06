require 'nokogiri'
require 'mechanize'
require 'restclient'
require 'yaml'
require 'json'
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
      login_form['login_id'] = APP_CONFIG["alumni_mckinsey_user"]
      login_form['password'] = APP_CONFIG["alumni_mckinsey_password"]

      loggedin_page = login_form.submit

      search_form = loggedin_page.forms.second

      search_form['keywords'] = @scrap.keyword.chomp

      result_page = search_form.submit

      total_result = result_page.search("#action_head").at('.left')

      unless total_result.text.scan(/\d+/).last.nil?
        @scrap.result = total_result.text.scan(/\d+/).last

        people = result_page.search("div[class='member clearfix']")
        @file = CSV.generate do |csv|
          csv << ["Keyword Input", "Name", "Email", "Member Type", "Title", "Company", "City"]
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
            csv << [@scrap.keyword.chomp, full_name, alumn_email, type, title, company, location]
          end
        end
      end
    elsif @scrap.url == "alumni.hbs.edu"
      page = mechanize.get("https://www.alumni.hbs.edu/community/Pages/directory-search.aspx?q=#{@scrap.keyword}&isHomeSearch=Yes#searchRefreshAnchor")
      login_form = page.forms.first

      login_form['username'] = APP_CONFIG["alumni_hbs_user"]
      login_form['password'] = APP_CONFIG["alumni_hbs_password"]

      result_page = login_form.submit

      total_result = result_page.search("#resultsNum").text.scan(/\d+/).first
      @scrap.result = total_result

      unless total_result.eql?("0")
        search_result = result_page.search("#search-results")


        @file = CSV.generate do |csv|
          csv << ["Keyword Input", "Full Name", "Title", "Company", "City", "Email", "Contact Number"]
          search_result.css("div.row div.span6 ul li").each do |row|
            name = row.css("div.results-mobile div.span5 span.mu-uc a").text
            city = row.css("div.results-mobile div.span5 span.mu-uc span.ash").text

            prof_desc = row.css("div.results-mobile div.span5 div.nu").text
            unless prof_desc.blank?
              title = row.css("div.results-mobile div.span5 div.nu").text.split(",")[0]
              company = row.css("div.results-mobile div.span5 div.nu").text.split(",")[1]
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

            csv << [@scrap.keyword.chomp, name, title, company, city, alumn_email, "#{alumn_contact[1]} / #{alumn_contact[1]}"]
          end
        end
      end
    elsif @scrap.url == "Linkedin.com"
      @file = CSV.generate do |csv|
        csv << ["id", "Keyword Input", "Zipcode Input", "firstName", "lastName", "headline", "location", "industry", "publicProfileUrl", 'company name', 'title', 'company size', 'isCurrent']
        json_txt = @scrap.access_token.get("/v1/people-search:(people:(id,first-name,last-name,email-address,headline,industry,location,network,public-profile-url,positions:(title,company:(name,size),is-current)),num-results)?keywords=#{@scrap.keyword.strip.gsub(" ", "+")}&country-code=us&postal-code=#{@scrap.zipcode.strip}&distance=40&facets=location&start=1&count=25&sort=distance", 'x-li-format' => 'json').body
        profile = JSON.parse(json_txt)
        
        if profile["numResults"] > 0
          profile["people"]["values"].each do |user|
            next if user['firstName'].eql?("private")
            positions = []
            user['positions']['values'].each do |pos|
              positions << {:company_name => pos['company']['name'], :title => pos['title'], :size => pos['company']['size']} if pos['isCurrent']
            end

            csv << [user["id"], @scrap.keyword.strip, @scrap.zipcode.strip, user["firstName"], user["lastName"], user["headline"], user["location"]["name"], user["industry"], user["publicProfileUrl"], positions.first[:company_name] || "", positions.first[:title] || "", positions.first[:size] || "", "Yes", ""]
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
