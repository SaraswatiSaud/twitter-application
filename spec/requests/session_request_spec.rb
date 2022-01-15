require 'rails_helper'

RSpec.describe 'Session', type: :request do
  before(:each) do
    @user = FactoryBot.create(:user)
    @signin_url = '/api/v1/auth/sign_in'
    @login_params = {
      email: @user.email,
      password: @user.password
    }
  end

  describe 'Login as a user' do
    context 'when user enters valid parameters' do
      before do
        post @signin_url, params: @login_params, as: :json
      end

      it 'returns status 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns access-token in authentication header' do
        expect(response.headers['access-token']).to be_present
      end

      it 'returns client in authentication header' do
        expect(response.headers['client']).to be_present
      end

      it 'returns uid in authentication header' do
        expect(response.headers['uid']).to be_present
      end
    end

    context 'when user enters invalid parameters' do
      before { post @signin_url }

      it 'returns unathorized status 401' do
        expect(response.status).to eq 401
      end
    end
  end
end
