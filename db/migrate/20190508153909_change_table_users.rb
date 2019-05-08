class ChangeTableUsers < ActiveRecord::Migration[5.2]
  def change
    change_table :users do |t|
      t.string :legal_first, null: false
      t.string :legal_last, null: false
      t.datetime :dob, null: false

      t.string :company_legal
      t.string :company_phone
      t.string :company_address1
      t.string :company_address2
      t.string :company_city
      t.string :company_province
      t.string :company_postalcode

    end
  end
end
