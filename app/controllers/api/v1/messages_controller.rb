module Api
  module V1
    class MessagesController < ApplicationController
      before_action :find_conversation
      
      def index
        @messages = @conversation.messages
        render json: @messages, status: 200
      end      

      def create
        @message = @conversation.messages.create!(message_params)
        if @message.save
          render json: @message, status: 200
        end
      end

      private

      def find_conversation        
        @conversation = Conversation.find(params[:conversation_id])
      end
      
      def message_params
        params.require(:message).permit(:body, :user_id)
      end
    end
  end
end