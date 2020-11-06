Rails.application.routes.draw do
  get 'attendances/index' #relier stripe aux participations
  delete '/event/:id/edit', to: 'event#destroy'
  devise_for :users
  
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  root to: 'events#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :events
  resources :users
  resources :attendances
end