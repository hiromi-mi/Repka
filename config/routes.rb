Rails.application.routes.draw do
  root 'application#hello'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :pieces, only: [:index, :create, :destroy]
  get '/download/template.csv', to: 'downloads#pieces_csv_template'
end
