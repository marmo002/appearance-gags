class User < ApplicationRecord
  has_secure_password

  has_one_attached :avatar
  has_one_attached :companylogo

  validates :first_name, :last_name, :email, :phone, presence: true
  validates :email, uniqueness: true
  validates :phone, format:{
    with: /\A\(\d{3}\).\d{3}.\d{4}\z/,
    message: 'must be in format (123) 456 7878'
  }
  validates :password, length: { minimum: 6 }, on: :create

  validate :image_validation, on: :update

  def full_name
    "#{first_name} #{last_name}"
  end

private

  def image_validation
    if avatar.blob.image?
      avatarImage = ActiveStorage::Analyzer::ImageAnalyzer.new(avatar.blob)
      errors.add :avatar, 'Image must be bigger than 700px' if avatarImage.metadata[:width] < 700
    else
      errors.add :avatar, 'File is not an image'
    end

    if companylogo.blob.image?
      companyImage = ActiveStorage::Analyzer::ImageAnalyzer.new(companylogo.blob)
      errors.add :companylogo, 'Image must be bigger than 700px' if companyImage.metadata[:width] < 700
    else
      errors.add :companylogo, 'File is not an image'
    end

  end


end
