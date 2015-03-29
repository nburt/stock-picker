Rails.application.routes.draw do
  root 'welcome#index'

  resources :stocks, only: [:new, :create, :show]
end
