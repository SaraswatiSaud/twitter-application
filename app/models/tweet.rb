class Tweet < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  has_many :likes, dependent: :destroy
end
