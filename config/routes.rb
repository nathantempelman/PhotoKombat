Rails.application.routes.draw do

  root 'pictures#compare'

  controller :static_pages do
    get 'about', to: :about
    get 'top', to: :top
  end

  resources :pictures do
    collection do
      get :compare
      post :compare_submit
      get :upload, to: :new
    end
  end

  resources :users do
    collection do
      get :signup, to: :new
    end
  end

  get '/signin', to: 'sessions#new'
  get '/signout', to: 'sessions#destroy'
  get '/signup',  to: 'users#new'
  resources :sessions, only: [:create]
end
