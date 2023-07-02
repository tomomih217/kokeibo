Rails.application.routes.draw do
  root 'top#index'
  get '/simulation', to: redirect('/')
  get '/privacypolicy', to: redirect('/')
  get '/termandcondition', to: redirect('/')

  resources :users, only: %i[new create]
  namespace :users do
    post 'confirm'
    get 'complete'
  end


  resources :children, only: %i[new create]
  resources :save_schedules, only: %i[new create]
  resources :simulation, only: %i[new create]

  get '/login', to: 'user_sessions#new'
  post '/login', to: 'user_sessions#create'
  delete '/logout', to: 'user_sessions#destroy'

  get '/mypage', to: 'mypage#show'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
