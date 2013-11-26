Livrodaclasse::Application.routes.draw do

  resources :publishers


  get "scraps/:id" => "scraps#show", as: :scrap_show
  match "scraps/create" => "scraps#create", as: :scrap_create

  mount Ckeditor::Engine => '/ckeditor'

  get 'entrar', :to => 'sessions#new', :as => :signin
  get 'auth/:provider/callback', :to => 'sessions#create'
  delete 'sair', :to => 'sessions#destroy', :as => :signout
  get 'cadastro', :to => 'users#new', :as => :new_user
  get 'apphome', :to => 'books#index', :as => :app_home
  get 'auth/failure', :to => redirect('/')
  get 'projects/terms_of_service', :to => 'projects#terms_of_service', :as => :terms_of_service
  match 'texts/enable_or_disable', :to => 'texts#enable_or_disable', :as => :enable_or_disable
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
  get 'books/:id/cover_info', to: 'books#cover_info', as: :book_cover_info
  match 'books/:id/update_cover_info', to: 'books#update_cover_info', as: :book_update_cover_info
  match 'books/:id/generate_cover', to: 'books#generate_cover', as: :book_generate_cover
  
  namespace :admin do
    root :to => 'dashboard#index'

    get 'dashboard/scraps', :to => 'dashboard#scraps', :as => :scraps
    get 'dashboard/default_cover', :to => 'dashboard#default_cover', :as => :default_cover
    match 'dashboard/update_default_cover', :to => 'dashboard#update_default_cover', :as => :update_default_cover
    resources :projects, :only => [:index, :show, :edit, :update] do
      member do
        get 'impersonate'
      end
    end
    resources :templates, :only => :index
    resources :expressions, :only => [:index, :create, :new, :edit, :update, :destroy]
  end
end
