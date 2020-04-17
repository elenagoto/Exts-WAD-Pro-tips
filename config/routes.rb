Rails.application.routes.draw do
  scope '(:locale)', locale: /en|fr|es/ do
    get 'sessions/new'

    root to: 'home#index'

    get  '/account', to: 'account#edit'
    post '/account', to: 'account#update'

    namespace :account do
      resources :tips, only: [:index]
    end

    resources :tips do
      resources :comments, only: [:create]
    end

    resources :sessions, only: [:new, :create, :destroy]

    resources :users

    # Login and Sign up routes
    get 'sign_up', to: 'users#new', as: 'signup'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
