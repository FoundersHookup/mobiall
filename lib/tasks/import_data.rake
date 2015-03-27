require 'csv' 

namespace :import_data do
  desc "Import Resources"
  task :resources => :environment do
    csv_text = File.read("#{Rails.root}/public/resources.csv")
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      resource = row.to_hash.with_indifferent_access
      p "************************Row From CSV*************************"
      
      r = Resource.create(
        :name => resource["Name"],
        :description => resource["Description"],
        :email => resource["Email"],
        :first_name => resource["First Name"],
        :last_name => resource["Last Name"],
        :position => resource["Position"],
        :show_comment_button => resource["Show Comment Button"] || false,
        :rating_option => resource["Rating Option"] || false,
        :other_company_option => resource["Other Company Option"] || false,
        :created_at => resource["Created At"],
        :updated_at => resource["Updated At"]
      )
      
      r.save(:validates => false)
    end
  end

  desc "Import Requested Users"
  task :requested_users => :environment do
    csv_text = File.read("#{Rails.root}/public/requested_users.csv")
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      resource = row.to_hash.with_indifferent_access
      p "************************Row From CSV*************************"
      r = RequestedUser.create(
        :resource_id => Resource.find_by_name(resource["Resource"]).id,
        :name => resource["Name"],
        :email => resource["Email"],
        :phone => resource["Phone"],
        :company_name => resource["Company Name"],
        :first_name => resource["First Name"],
        :last_name => resource["Last Name"],
        :feedback => resource["Feedback"],
        :is_anonymous => resource["Is Anonymous"],
        :other_company_name => resource["Other Company Name"],
        :created_at => resource["Created At"],
        :updated_at => resource["Updated At"]
      )

      r.save(:validates => false)
    end
  end

  desc "Import Feedbacks"
  task :feedbacks => :environment do
    csv_text = File.read("#{Rails.root}/public/feedbacks.csv")
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      feedback = row.to_hash.with_indifferent_access
      next if feedback["Resource"].blank?
      p "************************Row From CSV*************************"
      r = Feedback.create(
        :resource_id => Resource.find_by_name(feedback["Resource"]).id,
        :email => feedback["Email"],
        :phone => feedback["Phone"],
        :company_name => feedback["Company Name"],
        :first_name => feedback["First Name"],
        :last_name => feedback["Last Name"],
        :feedback => feedback["Feedback"],
        :is_anonymous => feedback["Is Anonymous"],
        :other_company_name => feedback["Other Company Name"],
        :user_rating => feedback["User Rating"],
        :created_at => feedback["Created At"],
        :updated_at => feedback["Updated At"]
      )

      r.save(:validates => false)
    end
  end
end