module Api
  module V1
    class MessagesController < ApplicationController
      before_action :find_conversation
      
      def index                
        @messages = @conversation.messages
        render json: @messages, status: 200
      end      

      def create
        @message = @conversation.messages.create(message_params)
        if @message.save
          render json: @message, status: 201
        end
      end

      private

      def find_conversation        
        @conversation = Conversation.find(params[:conversation_id])
      end
      
      def message_params
        params.permit(:body, :user_id, :conversation_id)
      end
    end
  end
end