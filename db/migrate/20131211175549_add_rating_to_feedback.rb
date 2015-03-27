class AddRatingToFeedback < ActiveRecord::Migration
  def change
    add_column :feedbacks, :user_rating, :string, :null => true
  end
end
