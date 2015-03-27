ActiveAdmin.register Resource do
  config.filters = false

  index do
    selectable_column
    column :name
    column :description
    column :email
    column :first_name
    column :last_name
    column :show_comment_button
    column :rating_option
    default_actions
  end

  batch_action :enable_rating_option do |selection|
      Resource.find(selection).each do |user|
        user.update_attribute :rating_option, true
      end
      redirect_to admin_resources_path, :notice => "Enabled Rating Option for Selected Resources!"
    end
  batch_action :enable_other_company_option do |selection|
      Resource.find(selection).each do |user|
        user.update_attribute :other_company_option, true
      end
      redirect_to admin_resources_path, :notice => "Enabled Other Company Option for Selected Resources!"
    end
  
  show do |ad|
      attributes_table do
        row :name
        row :first_name
        row :last_name
        row :description
        row :email
        row :position
        row :logo_url
        row :show_comment_button
        row :rating_option
      end
      render "requested_users"
#      active_admin_comments
    end
end
