class MediaFile < ApplicationRecord
  belongs_to :booking

  # SCOPES
  default_scope { order(created_at: :desc) }

end
