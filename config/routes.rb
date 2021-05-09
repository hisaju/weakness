Rails.application.routes.draw do
  root 'messages#index'
  resources :messages
  post '/messages/:id', to: 'messages#update'
end
