class AddColumnsToUser < ActiveRecord::Migration[5.2]
  def self.up
    change_table :users do |t|
      t.string :city
      t.string :state
      t.string :country
      t.string :company_country
    end
  end

  def self.down
    change_table :users do |t|
      t.remove  :city,
                :state,
                :country,
                :company_country
    end
  end
end
