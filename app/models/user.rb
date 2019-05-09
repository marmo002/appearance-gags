class User < ApplicationRecord
  has_secure_password

  has_one_attached :avatar
  has_one_attached :companylogo

  has_many :bookings, dependent: :destroy

  validates :email, :phone, presence: true
  validates :first_name, :last_name, :dob, presence: true, on: :update
  validates :email, uniqueness: true
  # validates :phone, format:{
  #   with: /\A\(\d{3}\).\d{3}.\d{4}\z/,
  #   message: 'must be in format (123) 456 7878'
  # }
  validates :password, length: { minimum: 6 }, on: :create

  # CUSTOM VALIDATIONS
  validate :image_validation, on: :update
  # validate :legal_info

  # SCOPES
  default_scope { order(first_name: :asc) }

  # CLASS METHODS
  def self.release_updated
    User.update_all( {signed_release: false} )
  end

  def self.search(search_term, user_id)
    by_name = where.not(id: user_id).where("first_name ILIKE ?", "%#{search_term}%").first(20)
    by_last = where.not(id: user_id).where("last_name ILIKE ?", "%#{search_term}%").first(20)
    by_email = where.not(id: user_id).where("email ILIKE ?", "%#{search_term}%").first(20)
    by_phone = where.not(id: user_id).where("phone LIKE ?", "%#{search_term}%").first(20)
    # by_last = where("lower(last_name) ILIKE ?", "%#{search_term.downcase}%")
    results = [by_name, by_last, by_email, by_phone].flatten.uniq

  end

  # INSTANCE METHODS
  def full_name
    "#{first_name} #{last_name}"
  end

  def dob_formatted
    dob.strftime("%B %d, %Y")
  end

  def get_hash_data(which_social)
    case which_social
    when "social_media"
      hash_to_clean = self.social_media
    when "company_social_media"
      hash_to_clean = self.company_social_media
    end

    if is_hash? hash_to_clean
      hash_to_clean.reject { |k, v| v.empty? }
    else
      false
    end
  end

  def get_social_media(user_attribute)
    new_r = {}
    social_hash = get_hash_data(user_attribute)
    if social_hash && social_hash.length > 0
          social_hash.each { |k, v|
            next if v.empty?
            if k == 'twitter'
              v = 'twitter.com/' + v.gsub(/\W/, '')
            elsif k == 'instagram'
              v = 'instagram.com/' + v.gsub(/\W/, '')
            else
              v = v.gsub(/https?:\/\//, '')
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
        errors.add :avatar, 'File is not an image'
      end
    end

    if companylogo.attached?
      unless companylogo.blob.image?
        errors.add :companylogo, 'File is not an image'
      end
    end
  end

  # Custom validation for legal_first, legal_last, and dob
  def legal_info
    # unless first_name == nil
    #   if first_name.empty?
    #     errors.add :legal_first, first_name
    #   end
    # end
    #
    # if legal_last.empty?
    #   errors.add :legal_last, 'Need a legal last name'
    # end
    #
    # if dob
    #   if dob.empty?
    #     errors.add :dob, 'Please add your date of birth'
    #   end
    # end
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
