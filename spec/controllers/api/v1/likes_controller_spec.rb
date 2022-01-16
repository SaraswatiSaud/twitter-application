require 'rails_helper'

describe Api::V1::LikesController, type: :controller do
  let(:current_user) { FactoryBot.create(:user) }
  let(:auth_headers) { current_user.create_new_auth_token }
  let(:new_user) { User.create(email: 'new_user@gmail.com', password: 'password') }

  before do
    @request.headers.merge!(auth_headers)  
    @tweet = FactoryBot.create(:tweet, user_id: new_user.id)    
  end

  describe '#create' do
    context 'when liking a tweet' do
      it 'should like a tweet' do
        expect do
          post :create, params: { tweet_id: @tweet.id, user_id: current_user.id }
        end.to change { Like.count }.by(1)               
      end

      it 'should returns a 201 response' do
        post :create, params: { tweet_id: @tweet.id, user_id: current_user.id }
        expect(response.status).to eq(201)
      end
    end
  end

  describe '#destroy' do
    context 'when unliking a tweet' do
      it 'should remove like of a specific tweet' do
        like = @tweet.likes.create(user_id: current_user.id, liked: true)        
        expect do
          delete :destroy, params: { id: like.id, tweet_id: @tweet.id }
        end.to change { Like.count }.by(-1)
      end
    end
  end
end