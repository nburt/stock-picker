Rails.application.routes.draw do
  resources :stocks, only: [:new, :create, :edit, :update] do
    member do
      post :download
    end
  end

  namespace :api do
    namespace :v1 do
      resources :stocks, only: [:index, :show] do
        member do
          get :stock_prices
          get :tweets
          get :articles
        end
      end

      namespace :analytics do
        resources :tweets, only: [] do
          collection do
            get :added
            get :total
            get :total_scored
            get :scored_by_interval
          end
        end

        resources :articles, only: [] do
          collection do
            get :added
            get :total
            get :total_scored
            get :scored_by_interval
          end
        end

        resources :reddits, only: [] do
          collection do
            get :added
            get :total
            get :total_scored
            get :scored_by_interval
          end
        end
      end
    end
  end

  get '*_', to: 'client#index'
end
