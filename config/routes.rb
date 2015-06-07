Rails.application.routes.draw do
  root 'categories#index'

  controller :static_pages do
    get 'about', to: :about
  end

  resources :categories, param: :handle, path: '/r' do
    member do
     get :compare
     post :compare_submit
     get :top
     get :upload, to: 'pictures#new', as: :upload_pictures
     post :upload, to: 'pictures#create'
    end

    resources :pictures
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
