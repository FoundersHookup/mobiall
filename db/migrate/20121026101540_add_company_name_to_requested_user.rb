class AddCompanyNameToRequestedUser < ActiveRecord::Migration
  def change
    add_column :requested_users, :company_name, :string
  end
end
