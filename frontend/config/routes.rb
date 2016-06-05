Rails.application.routes.draw do
  resources :hotels
  root to: 'hotels#index'
end
