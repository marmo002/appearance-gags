class AddDefaultValueToUserInfoAndHardwareRequirements < ActiveRecord::Migration[5.2]
  def up
    change_column_default :bookings, :user_info, from: nil, to: {}
    change_column_default :bookings, :hardware_requirements, from: nil, to: {}
  end

  def down
    change_column_default :bookings, :user_info, from: {}, to: nil
    change_column_default :bookings, :hardware_requirements, from: {}, to: nil
  end
end
