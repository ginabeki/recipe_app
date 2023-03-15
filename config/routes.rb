Rails.application.routes.draw do
  devise_for :users
 
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "foods#index"
  get '/public_recipes', to: 'recipes#public_recipes'
  
  resources :foods, only: [:index, :new, :create, :destroy]
  resources :users, only: [:index]
    resources :recipes, only: [:index, :new, :create, :show, :destroy]
  
end
