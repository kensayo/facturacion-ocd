Rails.application.routes.draw do

  resources :transactions
  root 'dashboard#index'
  get '/login',  to: 'sessions#new'
  post   '/login',  to: 'sessions#create'  # Procesa el envío del formulario
  delete '/logout', to: 'sessions#destroy' # Para cerrar sesión

  get "up" => "rails/health#show", as: :rails_health_check
  
end
