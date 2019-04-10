class AddSignedReleaseColumnToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :signed_release, :boolean, default: false
  end
end
