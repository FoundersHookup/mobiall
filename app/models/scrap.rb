class Scrap < ActiveRecord::Base
  attr_accessible :keyword, :result, :url, :email


  validates :email, :keyword, :presence => true
end
