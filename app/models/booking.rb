class Booking < ApplicationRecord
  belongs_to :user

  # validates :points, numericality: true
  validates :info_confirmation, acceptance: { message: '- Please confirm informatin is current and accurate' }
  validate :hardware_requirements
  # validate :test_date_before_recording_date

  def hardware_requirements
    unless params[booking][hardware_requirements][headphone]
      errors.add(:hardware_requirements, "Please confirm hardware requirements")
    end
  end

  def test_date_before_recording_date
    return if end_date.blank? || start_date.blank?

    if end_date < start_date
      errors.add(:end_date, "must be after the start date")
    end
  end
end
