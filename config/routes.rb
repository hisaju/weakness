Rails.application.routes.draw do
  root 'tops#index'
  match '/', to: 'tops#index', via: :all
end
