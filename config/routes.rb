Studyfiles::Application.routes.draw do

  devise_for :users, :controllers => { :registrations => "registrations" },:sign_out_via => [ :post, :delete, :get ]

  resources :documents
  resources :universities
  resources :folders do
    member do 
      get 'download'
    end
  end
  resources :users do
    resources :documents
  end
  resources :faqs
  resources :novelties
  resources :subjects
  resource :feedback, :controller => 'feedback', :only => [:new, :create]
  
  root :to => "universities#index"
end
