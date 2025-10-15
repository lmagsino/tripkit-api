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

        resources :expenses
        resources :itinerary_items
      end
    end
  end
end