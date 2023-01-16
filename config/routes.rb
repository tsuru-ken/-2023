Rails.application.routes.draw do
  root "tasks#index"
  resources :users, only:  [:new, :create]
  resources :tasks do
    collection do
      post :confirm
    end
  end
end
