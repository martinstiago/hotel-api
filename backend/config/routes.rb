Rails.application.routes.draw do
  resources :hotels
  resources :accomodation_types, only: [:index, :show]
  # get 'accomodation-types', to: 'accomodation_types#index'
  # get 'accomodation_types/:id', to: 'accomodation_types#show'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
