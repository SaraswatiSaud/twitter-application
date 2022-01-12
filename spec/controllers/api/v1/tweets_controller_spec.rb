# frozen_string_literal: true

require 'rails_helper'

describe Api::V1::TweetsController, type: :controller do  
  let(:current_user) { User.create(
                                    email: 'test@example.com', 
                                    password: 'password',
                                    password_confirmation: 'password') }
  let(:auth_headers) { current_user.create_new_auth_token }
  let(:tweet) { create :tweet, user_id: current_user.id }

  before do
    @request.headers.merge!(auth_headers)
  end

  context 'when listing tweets' do
    it 'should have status code 200' do
      get :index
      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)['data'].count).to eq(Tweet.count)
    end
  end

  context 'when creating a new tweet' do
    it 'should save a tweet with status 201 created' do
      post :create
      expect(response.status).to eq(201)
    end
    
    it 'should save a tweet with attributes' do
      expect do
        post :create, params: { tweet: attributes_for(:tweet) }
      end.to change { Tweet.count }.by(1)
    end
  end

  context 'when viewing a single tweet' do
    it 'should show details of that particular tweet' do
      get :show, params: { id: tweet.id }
      tweet_content = JSON.parse(response.body)['data']['attributes']['content']
      expect(tweet_content).to eq('This is test.')
      expect(response.status).to eq(200)
    end
  end

  context 'when updating a single tweet' do
    it 'should update tweet with new params' do
      put :update, params: { id: tweet.id, content: 'Edited tweet.' }
      new_tweet_content = JSON.parse(response.body)['data']['attributes']['content']
      expect(new_tweet_content).to eq('Edited tweet.')
      expect(response.status).to eq(200)
    end
  end

  context 'when deleting tweet' do
    it 'should have status code 204' do
      expect do
        delete :destroy, params: { id: tweet.id }
      end.to change { tweet.count }.by(-1)
      expect(response.status).to eq(204)
    end
  end
end
