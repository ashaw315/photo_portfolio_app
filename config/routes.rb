Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :users
  resources :portfolios do
    resources :photos
    resources :articles
    resources :videos
  end
  resources :records
  resources :comments, only: [:create, :destroy]
  resources :likes, only: [:create, :destroy]

end
