Rails.application.routes.draw do
  resources :books
  resources :authors
  resources :topics

  root 'books#index'

  resources :book_authors
  resources :book_topics
end
