class Booking < ApplicationRecord
  belongs_to :user

  # attr_accessor :info_confirmation

  validates :booking_type, inclusion: { in: %w(in-studio virtual),
            :message => "Please choose a valid booking type" }
  validates :show_name, inclusion: { in: %w(life lighting),
            :message => "Please choose a valid show name" }
  validates :test_date, presence: true, if: :type_virtual?
  validates :recording_date, presence: true
  # validates :info_confirmation, acceptance: { message: '- Please confirm information is current and accurate' }

  # Custom validations
  validate :dates_cant_be_past_today
  validate :harware_speed_requirements, if: :type_virtual?

  default_scope { order(recording_date: :asc) }
  scope :past, lambda { where("recording_date < ?", Date.today) }
  scope :upcomming, lambda { where("recording_date >= ?", Date.today) }

# READERS(GETTERS)

  def full_name
    user_info['full_name'] if user_info
  end

  def email
    user_info['email'] if user_info
  end

  def phone
    user_info['phone'] if user_info
  end

  def name_for_show
    user_info['name_for_show'] if user_info
  end

  def title_for_show
    user_info['title_for_show'] if user_info
  end

  def bio
    user_info['bio'] if user_info
  end

  def release
    user_info['release'] if user_info
  end

  # INSTANCE METHODS

  def clean_social_media
    convert_handles_from(clean_social_media_hash("social_media"))
  end

  def clean_company_social_media
    convert_handles_from( clean_social_media_hash("company_social_media") )
  end


private

  def clean_social_media_hash(string)
    if user_info && user_info[string]
      user_info[string].delete_if { |k, v|
        v == '0'
      }
    else
      false
    end
  end

  def convert_handles_from(social_media_hash)
    new_r = {}
    if is_hash? social_media_hash
      social_media_hash.each { |k, v|
        next if v.empty?
        if k == 'twitter' || k == 'company_twitter'
          v = 'twitter.com/' + v.gsub(/\W/, '')
        elsif k == 'instagram' || k == 'company_instagram'
          v = 'instagram.com/' + v.gsub(/\W/, '')
        end
        new_r[k] = v
      }
      new_r
    else
      false
    end
  end

  def is_hash?(item)
    item.class == Hash
  end

  def type_virtual?
    booking_type == "virtual"
  end#type_virtual?

  def harware_speed_requirements

      unless hardware_requirements['audio']
        errors.add(:audio_hardware, "Please choose an audio requirement option")
      end

      unless hardware_requirements['video']
        errors.add(:video_hardware, "Please choose a video requirement option")
      end

      unless hardware_requirements['computer_type']
        errors.add(:computer_type, "Please confirm computer type")
      end

      unless hardware_requirements['browser_type']
        errors.add(:browser_type, "Please confirm the browser your are using")
      end

      if hardware_requirements['ping'].length < 1
        errors.add(:intenet_requirements, "Verify ping")
      end

      if hardware_requirements['download'].length < 1
        errors.add(:intenet_requirements, "Verify download")
      end

      if hardware_requirements['upload'].length < 1
        errors.add(:intenet_requirements, "Verify upload")
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
  end#dates_cant_be_past_today

end
