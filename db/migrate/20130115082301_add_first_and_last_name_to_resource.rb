class AddFirstAndLastNameToResource < ActiveRecord::Migration
  def change
    add_column :resources, :first_name, :string
    add_column :resources, :last_name, :string
  end
end
