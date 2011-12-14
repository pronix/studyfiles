Studyfiles::Application.routes.draw do

  devise_for :users, :controllers => { :registrations => "registrations" },:sign_out_via => [ :post, :delete, :get ]

  resources :documents do
    member do
      get 'download'
    end
  end
  resources :universities do
    resources :folders
    resources :subjects
  end

  resources :folders do
    member do
      get 'download'
    end
  end

  resources :users do
    resources :documents
    resources :universities
  end

  resources :faqs
  resources :novelties
  resources :subjects
  resource :feedback, :controller => 'feedback', :only => [:new, :create]
  resources :logs

  root :to => "universities#index"
end
