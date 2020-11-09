Rails.application.routes.draw do
  get 'avatars/create'
  get 'attendances/index' #relier stripe aux participations
  delete '/events/:id/edit', to: 'event#destroy'
  
  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  root to: 'events#index'
 
  resources :events do
    resources :avatars, only: [:create]
  end

  resources :users
  resources :attendances
  resources :charges

  namespace :admin do
		get 'index'
		resources :users
		resources :events
  end

  post 'create_attendance' => 'attendances#create', as: :create_attendance
  
end