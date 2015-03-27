ActiveAdmin.register Feedback do
  config.filters = false

  csv do
      column :id
      column :feedback
      column :is_anonymous
      column :first_name
      column :last_name
      column :email
      column :company_name
      column :user_rating
      column("Resource") { |feedback| feedback.try(:resource).try(:name) }
  end
end
