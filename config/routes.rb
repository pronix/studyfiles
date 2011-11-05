Studyfiles::Application.routes.draw do

  devise_for :users

  root :to => "universities#index"
  resources :documents
  resources :universities
  resources :folders
  resources :users
  resources :faqs
  resources :novelties
  resources :subjects
end
