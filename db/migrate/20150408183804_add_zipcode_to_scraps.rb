class AddZipcodeToScraps < ActiveRecord::Migration
  def change
    add_column :scraps, :zipcode, :string
    add_column :scraps, :auth_code, :string
  end
end
