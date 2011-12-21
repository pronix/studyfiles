Studyfiles::Application.routes.draw do

  devise_for :users, :controllers => { :registrations => "registrations" },
  :sign_out_via => [ :post, :delete, :get ]

  resources :documents do
    resources :votes
    member do
      get 'download'
      put 'rate'
    end
  end
  resources :universities do
    collection do
      get 'search'
      post 'preview_logo'
    end
    member do
      put 'add_user'
    end
    resources :folders
    resources :subjects
  end

  resources :folders do
    member do
      get 'download'
      post 'move'
    end
  end

  resources :users do
    resources :documents
    resources :universities
  end

  resource :account

  resources :faqs
  resources :novelties
  resources :subjects do
    member do
      put 'add_user'
    end
  end
  resource :feedback, :controller => 'feedback', :only => [:new, :create]
  resources :logs
  resources :files

  root :to => "universities#index"
end
