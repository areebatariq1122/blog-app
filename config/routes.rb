Rails.application.routes.draw do  
  devise_for :users, controllers: {
          sessions: 'users/sessions',
          registrations: 'users/registrations'
        }
  root "articles#index"
  
  namespace :api do
    namespace :v1 do
      resources :articles
    end
  end

  resources :articles do
    resources :comments
  end
end