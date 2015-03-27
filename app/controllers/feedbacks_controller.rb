class FeedbacksController < ApplicationController
  def create
    @feedback = Feedback.create(params[:requested_user])
    @feedback.save
  end


  def edit
    @feedback = Feedback.find params[:id]
  end

  def update
    @feedback = Feedback.find params[:id]
    if @feedback.update_attributes(params[:feedback])
      ResourceMailer.feedback_email(@feedback).deliver
    end
  end
end
