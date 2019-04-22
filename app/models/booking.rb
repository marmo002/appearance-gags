class Booking < ApplicationRecord
  belongs_to :user

  attr_accessor :info_confirmation

  validates :recording_date, :recording_time, presence: true
  validates :test_date, :test_time, presence: true, if: :type_virtual?
  # validates :test_time, presence: true, if: :type_virtual?
  validate :dates_cant_be_past_today
  validate :harware_speed_requirements, if: :type_virtual?
  validates :info_confirmation, acceptance: { message: '- Please confirm information is current and accurate' }

private

  def type_virtual?
    type == "virtual"
  end

  def harware_speed_requirements

      unless hardware_requirements['headphone']
        errors.add(:hardware_requirements, "Please confirm you have proper headphones")
      end

      unless hardware_requirements['webcam']
        errors.add(:hardware_requirements, "Please confirm you have proper webcam")
      end

      if hardware_requirements['ping'].length < 2
        errors.add(:hardware_requirements, "Verify ping")
      end

      if hardware_requirements['download'].length < 2
        errors.add(:hardware_requirements, "Verify download")
      end

      if hardware_requirements['upload'].length < 2
        errors.add(:hardware_requirements, "Verify upload")
      end

  end#harware_speed_requirements

  def dates_cant_be_past_today
    if recording_date.present? && recording_date < Date.today
      errors.add(:recording_date, "can't be in the past")
    end

    if type_virtual?
      if test_date.present? && test_date > recording_date
        errors.add(:test_date, "can't be after recording date")
      end
    end
  end

end
