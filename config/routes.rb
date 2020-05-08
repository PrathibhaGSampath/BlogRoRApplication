Rails.application.routes.draw do
  devise_for :users, controllers: {sessions: 'users/sessions'}
  root "homes#index"
  resources :posts do
    member do
      patch :activate_post, as: :activate
      patch :archive_post, as: :archive
    end
    resources :comments, except: [:destroy]
  end
  resources :comments, only: [:destroy]


end