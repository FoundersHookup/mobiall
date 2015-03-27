ActiveAdmin.register RequestedUser do
  index do
    column :id
    column :name
    column :email
    column :company_name
    column :resource
    default_actions
  end

  csv do
      column :id
      column("Resource") { |requested_user| requested_user.resource.try(:name) }
      column :name
      column :email
      column :phone
      column :company_name
      column :first_name
      column :last_name
      column :feedback
      column :is_anonymous
      column :other_company_name
      column :created_at
      column :updated_at
  end
end
