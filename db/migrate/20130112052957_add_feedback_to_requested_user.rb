class AddFeedbackToRequestedUser < ActiveRecord::Migration
  def change
    add_column :requested_users, :feedback, :text
    add_column :requested_users, :is_anonymous, :boolean
  end
end
