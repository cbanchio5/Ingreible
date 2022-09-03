Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :users, except: [:index]

  resources :favourites, only: [:index, :show, :destroy]

  resources :recipes do
    resources :favourites, only: [:create]
    resources :reviews, only: [ :new, :create ]
  end

  resources :community do
    resources :messages
    resources :memberships
  end

end
