class ChangeUserTable < ActiveRecord::Migration[5.2]
  change_table :users do |t|
    t.string :name_for_show
    t.string :title_for_show
    t.text :bio
    t.rename :personal_info, :social_media
    t.string :company_name
    t.rename :company_info, :company_social_media
    t.index :email
  end
end
