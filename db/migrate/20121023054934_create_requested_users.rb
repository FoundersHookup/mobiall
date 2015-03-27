class CreateRequestedUsers < ActiveRecord::Migration
  def change
    create_table :requested_users do |t|
      t.references  :resource
      t.string      :name
      t.string      :email
      t.string      :phone
      
      t.timestamps
    end
  end
end
