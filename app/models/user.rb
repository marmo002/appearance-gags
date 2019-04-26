class User < ApplicationRecord
  has_secure_password

  has_one_attached :avatar
  has_one_attached :companylogo

  has_many :bookings

  validates :first_name, :last_name, :email, :phone, presence: true
  validates :email, uniqueness: true
  # validates :phone, format:{
  #   with: /\A\(\d{3}\).\d{3}.\d{4}\z/,
  #   message: 'must be in format (123) 456 7878'
  # }
  validates :password, length: { minimum: 6 }, on: :create

  validate :image_validation, on: :update

  default_scope { order(id: :desc) }

  def full_name
    "#{first_name} #{last_name}"
  end

  def social_media_alt
    new_r = {}
    if is_hash? social_media
      social_media.each { |k, v|
        next if v.empty?
        if k == 'twitter'
          v = 'twitter.com/' + v.gsub(/\W/, '')
        elsif k == 'instagram'
          v = 'instagram.com/' + v.gsub(/\W/, '')
        end
        new_r[k] = v
      }
      new_r
    else
      false
    end
  end

private

  def is_hash?(item)
    item.class == Hash
  end

  # IMAGE VALIDATION VALIDATES IT'S AN IMAGE
  def image_validation
    if avatar.attached?
      unless avatar.blob.image?
        errors.add :avatar, '- File is not an image'
      end
    end

    if companylogo.attached?
      unless companylogo.blob.image?
        errors.add :companylogo, '- File is not an image'
      end
    end
  end

  # IMAGE VALIDATION VALIDATES IT IMAGE AND IT'S A LEATS 700PX WIDE
  # def image_validation
  #   if avatar.attached?
  #     if avatar.blob.image?
  #       avatarImage = ActiveStorage::Analyzer::ImageAnalyzer.new(avatar.blob)
  #       errors.add :avatar, 'Image must be bigger than 700px' if avatarImage.metadata[:width] < 700
  #     else
  #       errors.add :avatar, 'File is not an image'
  #     end
  #   end
  #
  #   if companylogo.attached?
  #     if companylogo.blob.image?
  #       companyImage = ActiveStorage::Analyzer::ImageAnalyzer.new(companylogo.blob)
  #       errors.add :companylogo, 'Image must be bigger than 700px' if companyImage.metadata[:width] < 700
  #     else
  #       errors.add :companylogo, 'File is not an image'
  #     end
  #   end
  # end


end
