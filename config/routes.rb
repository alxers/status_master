Rails.application.routes.draw do
  resources :statuses
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks'}

  root 'statuses#index'
end
