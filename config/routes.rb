Rails.application.routes.draw do
  root 'application#hello'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :pieces, only: [:index, :create, :destroy, :edit, :update]
end
