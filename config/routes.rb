Livrodaclasse::Application.routes.draw do

  mount Ckeditor::Engine => '/ckeditor'

  require 'sidekiq/web'
  mount Sidekiq::Web, at: '/sidekiq'

  match 'scraps/:id/new', :to => 'scraps#new', :as => :new_scrap

  get 'wizard', :to => 'new_ui#wizard'
  get 'home', :to => 'new_ui#home'
  get 'saiba', :to => 'new_ui#saiba'

  get 'entrar', :to => 'sessions#new', :as => :signin
  get 'auth/:provider/callback', :to => 'sessions#create'
  delete 'sair', :to => 'sessions#destroy', :as => :signout
  get 'cadastro', :to => 'users#new', :as => :new_user
  get 'apphome', :to => 'books#index', :as => :app_home
  get 'auth/failure', :to => redirect('/')
  get 'projects/terms_of_service', :to => 'projects#terms_of_service', :as => :terms_of_service
  match 'texts/enable_or_disable', :to => 'texts#enable_or_disable', :as => :enable_or_disable
  root :to => 'new_ui#home'

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
  get 'books/:id/revision', to: 'books#revision', as: :book_revision
  match 'books/:id/update_cover_info', to: 'books#update_cover_info', as: :book_update_cover_info
  match 'books/:id/generate_cover', to: 'books#generate_cover', as: :book_generate_cover

  match 'books/:id/generate_pdf', to: 'books#generate_pdf', as: :book_generate_pdf
  match 'books/:id/generate_ebook', to: 'books#generate_ebook', as: :book_generate_ebook

  match 'scraps/:id/thread', :to => 'scraps#thread', :as => :scraps_thread
  match 'scraps/:id/answer', :to => 'scraps#answer', :as => :scraps_answer
  resources :scraps, :only => [:index, :create, :edit, :update, :destroy]

  namespace :admin do
    root :to => 'dashboard#index'

    match 'scraps/:id/thread', :to => 'scraps#thread', :as => :scraps_thread
    match 'scraps/:id/answer', :to => 'scraps#answer', :as => :scraps_answer

    match 'users/:id/books', :to => 'users#books', :as => :users_books
    match 'users/add_book', :to => 'users#add_book', :as => :users_add_book
    match 'users/remove_book', :to => 'users#remove_book', :as => :users_remove_book

    get 'dashboard/default_cover', :to => 'dashboard#default_cover', :as => :default_cover
    match 'dashboard/update_default_cover', :to => 'dashboard#update_default_cover', :as => :update_default_cover

    match 'dashboard/revision', :to => 'dashboard#revision', :as => :revision

    match 'projects/refresh', :to => 'projects#refresh', :as => :projects_refresh

    match 'projects/push', :to => 'projects#push', :as => :projects_push

    resources :projects, :only => [:index, :show, :edit, :update] do
      member do
        get 'impersonate'
        get 'refresh'
        get 'push'
      end
    end
    resources :templates, :only => :index
    resources :expressions, :only => [:index, :create, :new, :edit, :update, :destroy]
    resources :book_statuses, :only => [:index, :create, :new, :edit, :update]
    resources :profiles, :only => [:index, :create, :new, :edit, :update]
    resources :permissions, :only => [:index, :edit, :update]
    resources :publishers, :only => [:index, :create, :new, :edit, :update, :destroy]
    resources :scraps, :only => [:index, :create, :new, :edit, :update, :destroy]
    resources :users, :only => [:index, :edit, :update]
  end
end
