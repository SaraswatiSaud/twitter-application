module Api
  module V1
    class TweetsController < ApplicationController
      def index
        tweets = Tweet.all
        render json: tweets, status: 200
      end

      def show
      end
    end
  end
end
