class AddTurnOptionToResources < ActiveRecord::Migration
  def change
    add_column :resources, :rating_option, :boolean, :null => false, :default => false
    add_column :resources, :other_company_option, :boolean, :null => false, :default => false
  end
end
