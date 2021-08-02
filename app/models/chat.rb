class Chat < ApplicationRecord
  belongs_to :uesr
  belongs_to :room
  validates :message, length: { maximum: 140 }
end
