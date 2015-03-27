class Feedback < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :email, :company_name, :resource_id, :feedback, :phone, :is_anonymous, :user_rating, :other_company_name

  belongs_to :resource

  validates :first_name, :presence => true
  validates :last_name, :presence => true,
                        :unless => Proc.new{|u| u.attributes['first_name'].blank?  }

  validates :email, :presence => true,
                    :unless => Proc.new{|u| u.attributes['first_name'].blank?  || u.attributes['last_name'].blank?}
  validates :email, :format => {:with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i},
                    :unless => Proc.new{|u| u.attributes['first_name'].blank? || u.attributes['last_name'].blank? || u.attributes['email'].blank? }

  validates :company_name, :presence => true,
                           :unless => Proc.new{|u| u.attributes['first_name'].blank? || u.attributes['last_name'].blank? || u.attributes['email'].blank? }

  def name
    "#{first_name} #{last_name}"
  end
end
