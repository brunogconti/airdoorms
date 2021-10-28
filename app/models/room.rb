class Room < ApplicationRecord
  has_many :matches
  belongs_to :user
  validates :room_type, inclusion: { in: %w(shared exclusive) }
end
