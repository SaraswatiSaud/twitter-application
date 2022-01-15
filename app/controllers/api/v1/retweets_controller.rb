module Api
  module V1
    class RetweetsController < ApplicationController
      before_action :authenticate_api_v1_user!
      before_action :set_tweet, only: :create
      before_action :find_retweet

      def create
        if @retweet.present?
          render json: { message: 'The tweet is already retweeted by this user.' }
        else
          retweet = @tweet.retweets.new(user_id: current_api_v1_user.id)
          if retweet.save
            render json: retweet, status: 200
          else
            render json: { error: retweet.errors.full_messages }
          end
        end
      end

      def destroy        
        if @retweet.destroy
          render json: { message: 'This user deleted the retweet.' }
        else
          render json: { error: @retweet.errors.full_messages }
        end
      end

      private

      def find_retweet
        @retweet = Retweet.find_by(
          user_id: current_api_v1_user.id,
          tweet_id: params[:tweet_id]
        )
      end

      def set_tweet
        @tweet = Tweet.find(params[:tweet_id])
        if @tweet.nil?
          render json: { error: 'Tweet not found.' }
        end
      end
    end 
  end
end