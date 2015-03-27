class AddEmailToResource < ActiveRecord::Migration
  def change
    add_column :resources, :email, :string
  end
end
