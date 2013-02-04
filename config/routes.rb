Livrodaclasse::Application.routes.draw do

  get 'entrar', :to => 'sessions#new', :as => :signin
  get 'auth/:provider/callback', :to => 'sessions#create'
  delete 'sair', :to => 'sessions#destroy', :as => :signout
  get 'cadastro', :to => 'users#new', :as => :new_user
  get 'apphome', :to => 'books#index', :as => :app_home
  get 'auth/failure', :to => redirect('/')

  root :to => "pages#home"

  resources :users do
    collection do
      get 'email'
    end
  end
  resources :sessions
  resources :password_resets
  resources :books do
    resources :texts do
      collection do
        post 'sort'
      end
    end
  end

end
