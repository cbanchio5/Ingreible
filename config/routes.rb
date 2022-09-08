Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :users, except: [:index] do
    resources :favourites, only: [:index, :show, :destroy]

  end


  resources :recipes do
    collection do
      get :myrecipes
    end
    resources :favourites, only: [:new, :create]
    resources :reviews, only: [ :new, :create ]
  end

  resources :communities do
    resources :messages
    resources :memberships
  end

end
