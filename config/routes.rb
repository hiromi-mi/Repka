Rails.application.routes.draw do
  root 'application#hello'
  get    '/gateway',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :pieces, only: [:index, :create, :destroy, :edit, :update]
end
