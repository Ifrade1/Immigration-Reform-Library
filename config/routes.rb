Rails.application.routes.draw do
get 'books/search'
devise_for :users
devise_scope :user do
  get '/users/sign_out' => 'devise/sessions#destroy'
end
 resources :books, only: [:index, :show, :search, :new, :create, :edit, :destroy]

  root 'books#index'
end
