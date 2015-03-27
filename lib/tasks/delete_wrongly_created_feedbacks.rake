desc "This task is called by admin to fetch User data from csv file"
task :delete_wrongly_created_feedbacks => :environment do
  Feedback.all.each do |f|
    f.delete if f.is_anonymous.nil?
  end
end