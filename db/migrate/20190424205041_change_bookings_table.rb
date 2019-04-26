class ChangeBookingsTable < ActiveRecord::Migration[5.2]
  def self.up
    change_table :bookings do |t|
      t.remove :recording_time, :test_time
      t.change :recording_date, :datetime
      t.change :test_date, :datetime
    end
  end

  def self.down
    change_table :bookings do |t|
      t.time :recording_time
      t.time :test_time
      t.change :recording_date, :date
      t.change :test_date, :date
    end
  end


end
