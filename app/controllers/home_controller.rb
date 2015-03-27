class HomeController < ApplicationController
  def index
    @alchemist_resource = Resource.where(:name => "Alchemist Accelerator")
    @resources = Resource.all - @alchemist_resource
    @requested_user = RequestedUser.new
  end
end
