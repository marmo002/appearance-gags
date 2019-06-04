class MediaFile < ApplicationRecord
  belongs_to :booking

  # ACTIVE STORAGE
  has_many_attached :uploads

  # SCOPES
  default_scope { order(created_at: :desc) }

end
