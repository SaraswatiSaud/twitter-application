require 'rails_helper'

describe Api::V1::TweetsController, type: :controller do  
  let(:current_user) { FactoryBot.create(:user) }
  let(:auth_headers) { current_user.create_new_auth_token }  

  before do
    @request.headers.merge!(auth_headers)
    @tweet = FactoryBot.create(:tweet, user_id: current_user.id)
  end

  context 'when listing tweets' do
    it 'should have status code 200' do
      get :index      
      expect(response.status).to eq(200)      
    end
  end

  context 'when creating a new tweet' do
    it 'should save a tweet with the attributes' do
      tweet_params = FactoryBot.attributes_for(:tweet)
      expect {
        post :create, params: { tweet: tweet_params }
      }.to change(current_user.tweets, :count).by(1)      
    end
  end

  context 'when viewing a single tweet' do
    it 'should show details of that particular tweet' do
      get :show, params: { id: @tweet.id }     
      tweet_content = JSON.parse(response.body)['content']
      expect(tweet_content).to eq('This is test.')
      expect(response.status).to eq(200)
    end
  end

  context 'when updating a single tweet' do
    it 'should update tweet with new params' do      
      put :update, params: { id: @tweet.id, content: 'This tweet is edited.' }      
      new_tweet_content = JSON.parse(response.body)['content']
      expect(new_tweet_content).to eq('This tweet is edited.')
      expect(response.status).to eq(200)
    end
  end

  context 'when deleting tweet' do
    it 'should delete the specific tweet' do
      expect do
        delete :destroy, params: { id: @tweet.id }
      end.to change { Tweet.count }.by(-1)      
    end
  end
end