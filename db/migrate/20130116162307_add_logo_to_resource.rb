class AddLogoToResource < ActiveRecord::Migration
  def change
    add_column :resources, :logo_url, :string
  end
end
