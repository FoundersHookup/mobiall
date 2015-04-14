require 'oauth'

class ScrapsController < ApplicationController
    consumer_options = { :site => APP_CONFIG['api_host'],
      :authorize_path => APP_CONFIG['authorize_path'],
      :request_token_path => APP_CONFIG['request_token_path'],
      :access_token_path => APP_CONFIG['access_token_path'] }

    consumer = OAuth::Consumer.new(APP_CONFIG['linkedin_key'], APP_CONFIG['linkedin_secret'], consumer_options)

    # Fetch a new access token and secret from the command line
    @@request_token = consumer.get_request_token

  def index
    @auth_url = @@request_token.authorize_url
    @scrape = Scrap.new
  end

  def create
    @scrape = Scrap.new(params[:scrap])
    if params[:scrap][:url] == "Linkedin.com"
      @scrape.access_token = @@request_token.get_access_token(:oauth_verifier => params[:scrap][:auth_code].strip)
    end

    if @scrape.save
      Delayed::Job.enqueue(ReportMailingJob.new(@scrape))
      redirect_to scraps_url, :notice => "Report will be send to your email."
    else
      render :index
    end
  end

  def service_restart
    system("touch #{Rails.root}/tmp/restart.txt")
    sleep(3)
    redirect_to scraps_url
  end
end
