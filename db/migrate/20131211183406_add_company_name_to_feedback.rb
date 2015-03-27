class AddCompanyNameToFeedback < ActiveRecord::Migration
  def change
    add_column :feedbacks, :other_company_name, :string, :null => true
  end
end
