class CreateCompanies < ActiveRecord::Migration[5.2]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :address1
      t.string :address2
      t.string :city
      t.string :province
      t.string :postal_code
      t.string :email
      t.string :phone
      t.string :fax
      t.text :release
      t.string :password_digest

      t.timestamps
    end
  end
end
