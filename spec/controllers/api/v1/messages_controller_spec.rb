require 'rails_helper'

describe Api::V1::MessagesController, type: :controller do  
  let(:current_user) { FactoryBot.create(:user) }
  let(:auth_headers) { current_user.create_new_auth_token }
  let(:new_user) { User.create(email: 'new_user@gmail.com', password: 'password') }

  before do
    @request.headers.merge!(auth_headers)
    @conversation = Conversation.create(
      sender_id: current_user.id,
      recipient_id: new_user.id
    )  
  end  

  describe '#create' do
    context 'when sending a new message' do
      it 'should create a message' do      
        expect do
          post :create, params: {            
            conversation_id: @conversation.id,
            user_id: current_user.id,
            body: 'This is text message'
          }
        end.to change { @conversation.messages.count }.by(1)      
      end    
    end
  end
end