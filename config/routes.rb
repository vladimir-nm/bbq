Rails.application.routes.draw do
  resources :subscriptions
  resources :comments
  devise_for :users
  root 'events#index'

  resources :users, only: %i[show edit update]
  resources :events do
    resources :comments, only: %i[create destroy]
    resources :subscriptions, only: %i[create destroy]
  end
end
