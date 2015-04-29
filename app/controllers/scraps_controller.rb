require 'oauth'
require 'yaml'
require 'json'

class ScrapsController < ApplicationController
    consumer_options = { :site => APP_CONFIG['api_host'],
      :authorize_path => APP_CONFIG['authorize_path'],
      :request_token_path => APP_CONFIG['request_token_path'],
      :access_token_path => APP_CONFIG['access_token_path'] }

    consumer = OAuth::Consumer.new(APP_CONFIG['linkedin_key'], APP_CONFIG['linkedin_secret'], consumer_options)

    # Fetch a new access token and secret from the command line
    @@request_token = consumer.get_request_token

  def index
    @scrap = Scrap.new
  end

  def create
    @scrap = Scrap.new(params[:scrap])
    if params[:scrap][:url] == "Linkedin.com"
      @auth_url = @@request_token.authorize_url
      mechanize = Mechanize.new do |agent|
        agent.user_agent_alias = (Mechanize::AGENT_ALIASES.keys - ['Mechanize']).sample
      end

      linkedin_auth_page = mechanize.get(@auth_url)
      linked_login_form = linkedin_auth_page.forms.first
      linked_login_form['session_key'] = APP_CONFIG["in_session_key"]
      linked_login_form['session_password'] = APP_CONFIG["in_session_password"]
      
      linkedin_authorized_page = linked_login_form.submit
      
      if linkedin_authorized_page.search(".wrapper").at(".content .access-code")
        @auth_code = linkedin_authorized_page.search(".wrapper").at(".content .access-code").text
      else
        Net::SSH.start( '74.207.244.214', 'root', :password => "@Kalpesh123" ) do| ssh |
          result = ssh.exec! 'cd /var/www/mobiall && touch tmp/restart.txt'
          puts result
        end
        sleep(3)
        redirect_to(scraps_url, :notice => "Oooppss.... Something went wrong. Please try again.")
      end
      
      @scrap.access_token = @@request_token.get_access_token(:oauth_verifier => @auth_code.strip)
    end

    if @scrap.save
      Delayed::Job.enqueue(ReportMailingJob.new(@scrap))
      redirect_to scraps_url, :notice => "Report will be send to your email."
    else
      render :index
    end
  end

  def service_restart
    Net::SSH.start( '74.207.244.214', 'root', :password => "@Kalpesh123" ) do| ssh |
      result = ssh.exec! 'cd /var/www/mobiall && touch tmp/restart.txt'
      puts result
    end
    sleep(3)
    redirect_to scraps_url
  end
end
