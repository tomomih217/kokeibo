Rails.application.routes.draw do
  root 'top#index'
  get '/simulation', to: redirect('/')
  get '/privacypolicy', to: redirect('/')
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
