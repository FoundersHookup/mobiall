class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.integer    :resource_id
      t.text       :feedback
      t.boolean    :is_anonymous
      t.string     :first_name
      t.string     :last_name
      t.string     :email
      t.string     :company_name
      t.string     :phone

      
      t.timestamps
    end
  end
end
