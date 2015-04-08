class Scrap < ActiveRecord::Base
  attr_accessible :keyword, :result, :url, :email, :zipcode, :auth_code, :access_token

  serialize :access_token

  validates :email, :keyword, :presence => true
end
