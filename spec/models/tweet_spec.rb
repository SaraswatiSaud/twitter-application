require 'rails_helper'

RSpec.describe Tweet, type: :model do  
  it 'is invalid without content' do
    user = FactoryBot.create(:user)
    tweet = user.tweets.new(content: nil)
    tweet.valid?
    expect(tweet.errors[:content]).to include("can't be blank")
  end
end