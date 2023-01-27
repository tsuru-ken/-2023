Rails.application.routes.draw do
  get 'sessions/new'
  root "tasks#index"
  resources :users, only: [:new, :create, :show, :edit, :update]
  resources :sessions, only: [:new, :create, :destroy]
  resources :labels, only: [:index, :create, :new, :edit, :update, :destroy]
  namespace :admin do
    resources :users
  end
  resources :tasks do
    collection do
      post :confirm
    end
  end
end
