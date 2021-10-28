Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :rooms
  resources :matches, except: [:new,:edit, :update]

  get "rooms/:id", to: 'matches#new', as: 'new_match'
  delete "rooms/:id", to: "rooms#destroy", as: 'delete_room'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
