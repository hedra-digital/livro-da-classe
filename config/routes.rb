Livrodaclasse::Application.routes.draw do

  mount Ckeditor::Engine => '/ckeditor'

  get 'entrar', :to => 'sessions#new', :as => :signin
  get 'auth/:provider/callback', :to => 'sessions#create'
  delete 'sair', :to => 'sessions#destroy', :as => :signout
  get 'cadastro', :to => 'users#new', :as => :new_user
  get 'apphome', :to => 'books#index', :as => :app_home
  get 'auth/failure', :to => redirect('/')
  get 'projects/terms_of_service', :to => 'projects#terms_of_service', :as => :terms_of_service

  root :to => 'pages#home'

  resources :users do
    collection do
      get 'email'
    end
  end

  resources :sessions
  resources :password_resets
  resources :books do
    resources :texts do
      resources :comments
      collection do
        post 'sort'
      end
    end
    resources :collaborators do
      member do
        get 'resend_invitation'
      end
    end
    resources :projects
  end

  namespace :admin do
    root :to => 'dashboard#index'

    resources :projects, :only => [:index, :show, :edit, :update] do
      member do 
        get 'impersonate'
      end
    end
    resources :templates, :only => :index
  end
end
