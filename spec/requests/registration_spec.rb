# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Registration', type: :request do
  before(:each) do
    @signup_url = '/api/v1/auth'
    @signup_params = {
      email: 'test@example.com',
      password: '12345678',
      password_confirmation: '12345678'
    }
  end

  describe 'Creates a new user' do
    describe 'POST /api/v1/auth' do
      context 'when user enters valid parameters' do
        before do
          post @signup_url, params: @signup_params
        end

        it 'returns status 200' do
          expect(response).to have_http_status(200)
        end

        it 'increase the user count by 1' do
          expect do
            post @signup_url, params: @signup_params.merge({ email: 'new_test@example.com' })
          end.to change(User, :count).by(1)
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
        before { post @signup_url }

        it 'returns unprocessable entity 422' do
          expect(response.status).to eq 422
        end
      end
    end
  end
end
