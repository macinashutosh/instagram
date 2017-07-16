class AddFullnameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :fullname, :string, null: false
  end
end
