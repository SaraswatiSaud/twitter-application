module Api
  module V1
    class ConversationsController < ApplicationController
      before_action :authenticate_api_v1_user!      

      def create        
        if Conversation.between(params[:sender_id], params[:recipient_id]).present? 
          @conversation = Conversation.between(params[:sender_id], params[:recipient_id]).first
        else
          @conversation = Conversation.create!(conversation_params)
        end
        render json: @conversation, status: 200        
      end

      private

      def conversation_params
        params.require(:conversation).permit(:sender_id, :recipient_id)
      end
    end
  end
end
