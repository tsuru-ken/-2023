Rails.application.routes.draw do
  get 'sessions/new'
  root "tasks#index"
  resources :users, only: [:new, :create, :show, :edit, :update]
  resources :sessions, only: [:new, :create, :destroy]
  resources :tasks do
    collection do
      post :confirm
    end
  end
end
