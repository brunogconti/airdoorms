class Room < ApplicationRecord
  has_many :matches
  belongs_to :user
  validates :room_type, inclusion: { in: %w(shared exclusive) }

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
