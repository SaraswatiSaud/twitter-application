class Like < ApplicationRecord
  belongs_to :tweet
  belongs_to :user

  validates_presence_of :liked  
end
