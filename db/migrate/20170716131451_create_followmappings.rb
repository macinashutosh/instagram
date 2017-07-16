class CreateFollowmappings < ActiveRecord::Migration
  def change
    create_table :followmappings do |t|
      t.integer :celeb_id
      t.integer :follower_id

      t.timestamps null: false
    end
  end
end
