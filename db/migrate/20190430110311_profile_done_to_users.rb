class ProfileDoneToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :profile_done, :boolean, default: false
  end
end
