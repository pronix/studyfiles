Studyfiles::Application.routes.draw do

  devise_for :users

  root :to => "home#index"
  resources :documents
  resources :folders
end
