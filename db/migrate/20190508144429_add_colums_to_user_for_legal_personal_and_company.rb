class AddColumsToUserForLegalPersonalAndCompany < ActiveRecord::Migration[5.2]
  change_table :users do |t|
    t.string :legal_first
    t.string :legal_last
    t.datetime :dob

    t.string :company_legal
    t.string :company_phone
    t.string :company_address1
    t.string :company_address2
    t.string :company_city
    t.string :company_province
    t.string :company_postalcode

  end
end
