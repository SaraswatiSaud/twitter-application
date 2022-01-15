module Api
  module V1
    class LikesController < ApplicationController
      before_action :authenticate_api_v1_user!
      before_action :find_like
      before_action :find_tweet, only: :create      

      def create
        if @like.present?
          render json: { message: 'The tweet is already liked by this user.' }
        else
          like = @tweet.likes.new(
            user_id: current_api_v1_user.id,
            liked: true
          )          
          if like.save
            render json: like, status: 200
          else
            render json: { error: like.errors.full_messages }
          end
        end
      end

      def destroy
        if @like.destroy
          render json: { message: 'This user has unliked the tweet.' }
        else
          render json: { error: @like.errors.full_messages }
        end
      end

      private

      def find_tweet
        @tweet = Tweet.find(params[:tweet_id])
      end

      def find_like
        @like = Like.find_by(user_id: current_api_v1_user.id, tweet_id: params[:tweet_id])
      end
    end
  end
end
