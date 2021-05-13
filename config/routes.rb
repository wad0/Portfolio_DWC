Rails.application.routes.draw do

  devise_for :users

  root 'homes#top'
  get 'homes/about' => 'homes#about'
  post 'homes/guest_sign_in' => 'homes#guest_sign_in'
  get 'users/:id/keeps' => 'users#keeps'

  resources :users, only: [:show,:edit,:update,:destroy]
  resources :comics do
    resource :keeps, only: [:create,:destroy,:index]
  end

end
