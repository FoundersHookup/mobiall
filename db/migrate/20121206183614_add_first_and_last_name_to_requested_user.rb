class AddFirstAndLastNameToRequestedUser < ActiveRecord::Migration
  def change
    add_column :requested_users, :first_name, :string
    add_column :requested_users, :last_name, :string
  end
end
