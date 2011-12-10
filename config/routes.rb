Studyfiles::Application.routes.draw do

  devise_for :users, :controllers => { :registrations => "registrations" },:sign_out_via => [ :post, :delete, :get ]

  root :to => "universities#index"
  resources :documents
  resources :universities do
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
end
