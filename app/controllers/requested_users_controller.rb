class RequestedUsersController < ApplicationController
  def create
    @requested_user = RequestedUser.create(params[:requested_user])

    if request.post?
      if params[:commit].eql?("Ok")
        
      elsif params[:commit].eql?("Connect Me In!")
        if @requested_user.save
          ResourceMailer.request_email(@requested_user).deliver
        end
      end
    end
  end

  def edit
    @requested_user = RequestedUser.find params[:id]
  end

  def update
    @requested_user = RequestedUser.find params[:id]
    if @requested_user.update_attributes(params[:requested_user])
      ResourceMailer.feedback_email(@requested_user).deliver unless params[:commit].eql?("Add Company")
    end
  end
end
