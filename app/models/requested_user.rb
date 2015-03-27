class RequestedUser < ActiveRecord::Base
  attr_accessible :name, :first_name, :last_name, :email, :company_name, :phone, :resource_id, :is_anonymous, :feedback, :other_company_name
  default_scope where("resource_id IS NOT NULL")
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

#  validates_uniqueness_of :email, :scope => [:first_name, :resource_id], :message => "Already Connected With This Company.",
#                          :unless => Proc.new{|u| u.attributes['first_name'].blank? || u.attributes['last_name'].blank? || u.attributes['email'].blank? || u.attributes['company_name'].blank?}


  def name
    "#{first_name} #{last_name}"
  end
end
