class AddOtherCompanyNameToRequestedUser < ActiveRecord::Migration
  def change
    add_column :requested_users, :other_company_name, :string, :null => true
  end
end
