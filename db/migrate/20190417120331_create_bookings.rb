class CreateBookings < ActiveRecord::Migration[5.2]
  def change
    create_table :bookings do |t|
      t.string :show_name, :null => false
      t.string :type, :null => false
      t.json :user_info
      t.date :test_date
      t.time :test_time
      t.date :recording_date
      t.time :recording_time
      t.json :hardware_requirements
      t.references :user, index: true, foreign_key: true
      
      t.timestamps
    end
  end
end
