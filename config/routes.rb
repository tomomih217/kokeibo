Rails.application.routes.draw do
  root 'top#index'
  get '/simulation', to: redirect('/')
  get '/privacypolicy', to: redirect('/')
  get '/termandcondition', to: redirect('/')

  resources :users, only: %i[new create show edit destroy]
  namespace :users do
    post 'confirm'
    get 'complete'
  end

  resources :children, only: %i[new create] do
    resources :plans, only: %i[index new create destroy], shallow: true
    patch '/plans', to: 'plans#update'
    put '/plans', to: 'plans#update'
    get '/plans/edit', to: 'plans#edit'
    resources :payment_collections, only: %i[index new create edit update destroy], shallow: true
    resources :simulation, only: %i[new edit], shallow: true
    post 'result', to: 'simulation#result'
    patch 'result', to: 'simulation#result'
    resources :results, only: %i[index create update], shallow: true
    get '/change', to: 'mypage#change_child'
  end

  get '/login', to: 'user_sessions#new'
  post '/login', to: 'user_sessions#create'
  delete '/logout', to: 'user_sessions#destroy'

  get '/mypage', to: 'mypage#show'
  get '/mypage/next', to: 'mypage#next_child'
  get '/mypage/previous', to: 'mypage#previous_child'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
