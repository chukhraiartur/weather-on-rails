Rails.application.routes.draw do
  # resources :locations, only: [:index]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"
  get '/clear_results', to: 'home#clear_results', as: 'clear_results'
end
