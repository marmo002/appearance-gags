class Company < ApplicationRecord

  validates :name, :address1, :city, :province, :postal_code, :email, :phone, :release, presence: true

end
