Studyfiles::Application.routes.draw do

  devise_for :users, :controllers => { :registrations => "registrations" },:sign_out_via => [ :post, :delete, :get ]

  root :to => "universities#index"
  resources :documents
  resources :universities
  resources :folders
  resources :users
  resources :faqs
  resources :novelties
  resources :subjects
end
