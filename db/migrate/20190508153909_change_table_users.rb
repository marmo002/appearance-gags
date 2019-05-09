class ChangeTableUsers < ActiveRecord::Migration[5.2]
  def self.up
    change_table :users do |t|
      t.date :dob

      t.string :company_legal_name
      t.string :company_phone
      t.string :company_address1
      t.string :company_address2
      t.string :company_city
      t.string :company_province
      t.string :company_postalcode

      t.index :first_name
      t.index :last_name
      t.index :phone
    end
  end

  def self.down
    change_table :users do |t|
      t.remove  :dob,
                :company_legal_name,
                :company_phone,
                :company_address1,
                :company_address2,
                :company_city,
                :company_province,
                :company_postalcode

      t.remove_index :first_name
      t.remove_index :last_name
      t.remove_index :phone
    end
  end
end
