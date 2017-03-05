class Micropost < ApplicationRecord
  belongs_to :user, counter_cache: true
  default_scope -> {order created_at: :desc}
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum: Settings.validates.content.max_length}
  validate :picture_size

  private

  def picture_size
    if picture.size > Settings.max_size_in_mb.megabytes
      errors.add :picture, t(".wrong_size")
    end
  end
end
