Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'pages#index'
  get 'about', to: 'pages#about'
  resources :articles # , only: %i[show index new create edit update destroy]
  # %i = Non-interpolated Array of symbols, separated by whitespace
  get 'signup', to: 'users#new'
  resources :users, except: %i[new]
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  resources :categories, except: %i[destroy]
end
