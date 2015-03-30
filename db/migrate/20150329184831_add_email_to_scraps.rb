class AddEmailToScraps < ActiveRecord::Migration
  def change
    add_column :scraps, :email, :string
  end
end
