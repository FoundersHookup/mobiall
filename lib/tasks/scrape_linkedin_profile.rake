require 'linkedin-scraper'

namespace :scrape_linkedin_profile do
  task :from_url => :environment do
    profile = Linkedin::Profile.get_profile("http://www.linkedin.com/pub/russell-ivanhoe-md/3/62b/406")
    puts "@@@@@@@@@@@@@"
    puts profile.first_name
    puts profile.last_name
  end
end