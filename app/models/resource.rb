class Resource < ActiveRecord::Base
  attr_accessible :description, :name, :email, :first_name, :last_name, :logo_url, :show_comment_button, :rating_option, :other_company_option

  default_scope order('name asc')

  has_many :requested_users

  acts_as_list
end
