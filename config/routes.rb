Rails.application.routes.draw do
  resources :books
  resources :authors
  resources :topics

  root 'books#index'
end
