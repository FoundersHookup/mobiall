class AddAccessTokenToScraps < ActiveRecord::Migration
  def change
    add_column :scraps, :access_token, :text
  end
end
