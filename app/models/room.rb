class Room < ApplicationRecord
  validates :room_type, inclusion: { in: %w(shared exclusive) }
end
