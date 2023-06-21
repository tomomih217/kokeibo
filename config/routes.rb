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
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
