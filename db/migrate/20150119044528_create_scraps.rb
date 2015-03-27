class CreateScraps < ActiveRecord::Migration
  def change
    create_table :scraps do |t|
      t.string :url
      t.string :keyword
      t.string :result

      t.timestamps
    end
  end
end
