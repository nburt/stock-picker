Rails.application.routes.draw do
  resources :stocks, only: [:new, :create, :edit, :update]

  namespace :api do
    namespace :v1 do
      resources :stocks, only: [:index, :show] do
        member do
          get :stock_prices
          get :tweets
          get :articles
        end
      end
    end
  end
end
