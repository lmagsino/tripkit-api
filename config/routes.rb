Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      # Authentication
      post 'auth/signup', to: 'authentication#signup'
      post 'auth/login', to: 'authentication#login'

      resources :trips do
        collection do
          post :join
        end

        member do
          get :settlement
        end

        resources :expenses
        resources :itinerary_items
        resources :documents
      end
    end
  end
end