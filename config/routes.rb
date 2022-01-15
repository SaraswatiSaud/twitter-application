Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'auth'
      resources :tweets do
        resources :likes, only: [:create, :destroy]
        resources :retweets, only: [:create, :destroy]
      end
      resources :conversations, only: :create do
        resources :messages, only: [:index, :create]
      end
    end
  end
end
