require 'rails_helper'

describe Api::V1::RetweetsController, type: :controller do
  describe '#create' do
    context 'as an authenticated user' do
      before do
        @user = FactoryBot.create(:user)
        @tweet = FactoryBot.create(:tweet, user_id: @user.id)
      end

      it 'retweet the tweet' do
        retweet_params = FactoryBot.attributes_for(:retweet)
        sign_in @user
        expect do
          post :create, params: { retweet: retweet_params }
        end.to change { Retweet.count }.by(1)
      end
    end    
  end
end