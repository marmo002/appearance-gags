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

  def full_name
    "#{first_name} #{last_name}"
  end

end
