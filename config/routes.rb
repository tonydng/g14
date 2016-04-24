Rails.application.routes.draw do
  resources :books
  resources :authors
  resources :topics
  resources :publishers
  resources :book_authors
	
  root 'books#index'

end
