Rails.application.routes.draw do
  resources :posts
  get 'main',to:"main#main"
  post 'login',to:"main#login"
  resources :users
  get 'create_fast', to:"users#create_fast"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
