Rails.application.routes.draw do
  devise_for :users
 
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "foods#index"
  get '/public_recipes', to: 'recipes#public_recipes'
  get '/ingredients/new', to: 'recipes#new_ingredient'
  post '/ingredients', to: 'recipes#create_ingredient'
 
  
  resources :foods, only: [:index, :show, :new, :create, :destroy]
  resources :users, only: [:index]
    resources :recipes, only: [:index, :new, :create, :show, :destroy] do
      member do
        get :toggle_public
      end
    end
  
end
