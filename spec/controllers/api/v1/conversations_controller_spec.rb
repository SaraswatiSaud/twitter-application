require 'rails_helper'

describe Api::V1::ConversationsController, type: :controller do  
  let(:current_user) { FactoryBot.create(:user) }
  let(:auth_headers) { current_user.create_new_auth_token }
  let(:new_user) { User.create(email: 'new_user@gmail.com', password: 'password') }

  before do
    @request.headers.merge!(auth_headers)    
  end

  describe '#create' do
    context 'when creating a new conversation' do
      it 'should create a conversation with the valid attributes' do      
        expect do
          post :create,
          params: { 
            conversation: FactoryBot.attributes_for(
              :conversation, 
              sender_id: current_user.id,
              recipient_id: new_user.id
            ) 
          }
        end.to change { Conversation.count }.by(1)      
      end    
    end
  end
end