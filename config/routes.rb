Rails.application.routes.draw do
  resources :urls
  match '/:id' => 'urls#show', via: :get
  match '/' => 'urls#index', via: :get
end
