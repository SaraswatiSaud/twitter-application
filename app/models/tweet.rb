class Tweet < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :content, presence: true
  has_many :likes, dependent: :destroy
  has_many :retweets, dependent: :destroy
end
