require 'oauth'

class ScrapsController < ApplicationController
    consumer_options = { :site => 'https://api.linkedin.com',
      :authorize_path => '/uas/oauth/authorize',
      :request_token_path => '/uas/oauth/requestToken',
      :access_token_path => '/uas/oauth/accessToken' }

    consumer = OAuth::Consumer.new('hv6bmdgsfd3m', 'rfOvMmqxkVQk7Bto', consumer_options)

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
end
