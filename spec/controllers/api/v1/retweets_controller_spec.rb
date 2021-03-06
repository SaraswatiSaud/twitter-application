require 'rails_helper'

describe Api::V1::RetweetsController, type: :controller do
  let(:current_user) { FactoryBot.create(:user) }
  let(:auth_headers) { current_user.create_new_auth_token }
  let(:new_user) { User.create(email: 'new_user@gmail.com', password: 'password') }

  before do
    @request.headers.merge!(auth_headers)  
    @tweet = FactoryBot.create(:tweet, user_id: new_user.id)    
  end

  describe '#create' do
    context 'when retweeting a tweet' do
      it 'should create a retweet' do
        expect do          
          post :create, params: { tweet_id: @tweet.id, user_id: current_user.id }
        end.to change { Retweet.count }.by(1)               
      end

      it 'should returns a 201 response' do
        post :create, params: { tweet_id: @tweet.id, user_id: current_user.id }
        expect(response.status).to eq(201)
      end
    end
  end

  describe '#destroy' do
    context 'when deleting a retweet' do
      it 'should delete the specific retweet' do
        retweet = @tweet.retweets.create(user_id: current_user.id)
        expect do
          delete :destroy, params: { id: retweet.id, tweet_id: @tweet.id }
        end.to change { Retweet.count }.by(-1)
      end
    end
  end
end