class ChangeUserRatingColumn < ActiveRecord::Migration
  def up
    change_column :feedbacks, :user_rating, :string, default: ""
  end

  def down
    change_column :feedbacks, :user_rating, :string
  end
end
