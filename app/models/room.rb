class Room < ApplicationRecord
  has_many :matches, dependent: :destroy
  belongs_to :user
  has_many_attached :photos

  validates :room_type, inclusion: { in: %w[shared exclusive] }

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
