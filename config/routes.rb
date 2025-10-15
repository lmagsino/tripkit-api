Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      # Authentication
      post 'auth/signup', to: 'authentication#signup'
      post 'auth/login', to: 'authentication#login'
    end
  end
end