Rails.application.routes.draw do

  devise_for :users

  root 'homes#top'
  get 'homes/about' => 'homes#about'
  post 'homes/guest_sign_in' => 'homes#guest_sign_in'

  resources :users, only: [:show,:edit,:update]
  resources :comics

end
