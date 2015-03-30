

class ScrapsController < ApplicationController
  def index
    @scrape = Scrap.new
  end

  def create
    @scrape = Scrap.new(params[:scrap])

    if @scrape.save
      Delayed::Job.enqueue(ReportMailingJob.new(@scrape))
      redirect_to scraps_url, :notice => "Report will be send to your email."
    else
      render :index
    end
  end
end
