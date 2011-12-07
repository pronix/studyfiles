Studyfiles::Application.routes.draw do

  devise_for :users

  root :to => "universities#index"
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
end
