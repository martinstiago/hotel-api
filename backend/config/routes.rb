Rails.application.routes.draw do
  resources :hotels
  resources :accomodation_types, only: [:index]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
