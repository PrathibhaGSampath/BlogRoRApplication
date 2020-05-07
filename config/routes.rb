Rails.application.routes.draw do
  devise_for :users, controllers: {sessions: 'users/sessions'}
  root "homes#index"
  resources :posts do
    resources :comments
  end
end
