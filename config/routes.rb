Rails.application.routes.draw do

  devise_for :users

  root 'homes#top'
  get 'homes/about'

  resources :users, only: [:show,:edit,:update]
  resources :comics

end
