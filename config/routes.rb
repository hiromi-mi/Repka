Rails.application.routes.draw do
  root 'application#hello'
  resources :pieces, only: [:index, :create, :destroy, :edit, :update]
end
