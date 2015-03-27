class AddShowCommentToResource < ActiveRecord::Migration
  def change
    add_column :resources, :show_comment_button, :boolean, :default => false
  end
end
