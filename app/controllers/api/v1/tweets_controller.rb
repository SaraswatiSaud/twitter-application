module Api
  module V1
    class TweetsController < ApplicationController
      before_action :authenticate_api_v1_user!
      before_action :find_params, only: %i[show update destroy]

      def index
        tweets = current_api_v1_user.tweets.all
        render json: tweets, status: 200
      end

      def create
        tweet = current_api_v1_user.tweets.new(
          content: tweet_params[:content]
        )
        if tweet.save
          render json: tweet, status: 200
        else
          render json: { error: 'Error while creating tweet' }
        end
      end

      def show
        render json: @tweet, status: 200
      end

      def update
        if @tweet.update(tweet_params)
          render json: @tweet, status: 200
        else
          render json: { error: 'Error while updating tweet' }
        end
      end

      def destroy
        if @tweet.destroy
          render json: { message: 'Tweet deleted successfully' }
        else
          render json: { error: 'Error while deleting tweet' }
        end
      end

      private

      def find_params
        @tweet = current_api_v1_user.tweets.find(params[:id])
      end

      def tweet_params
        params.require(:tweet).permit(:id, :content, :user_id)
      end
    end
  end
end
