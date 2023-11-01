Rails.application.routes.draw do
  root "articles#index"

  
  devise_for :users, controllers: {
          sessions: 'users/sessions',
          registrations: 'users/registrations'
        }
  
  namespace :api do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'auth', controllers: {
        sessions: 'api/v1/users/sessions',
        registrations: 'api/v1/users/registrations'

      }
      resources :articles
    end
  end

  resources :articles do
    resources :comments
  end
end
