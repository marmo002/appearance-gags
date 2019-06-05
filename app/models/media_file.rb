class MediaFile < ApplicationRecord
  belongs_to :booking

  # ACTIVE STORAGE
  has_many_attached :uploads

  # SCOPES
  default_scope { order(created_at: :desc) }

  #VALIDATIONS
  validates :title, :audio_link, :video_link, presence: true

  #CUSTOM VALIDATIONS
  validate :uploads_validation

  private

  def uploads_validation
    error_message = ''
    uploads_valid = true
    if uploads.attached?
      uploads.each do |upload|
        if !upload.blob.content_type.in?(%w( pdf application/pdf image/jpeg image/jpg image/png))
          uploads_valid = false
          error_message = 'Wrong file format'
        end
      end
    end
    unless uploads_valid
      errors.add(:uploads, error_message)
      uploads.each do |upload|
        upload.purge_later
      end
    end
  end

end
