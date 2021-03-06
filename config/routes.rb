Rails.application.routes.draw do
  devise_for :users

  root 'homes#top'
  post 'homes/guest_sign_in' => 'homes#guest_sign_in'

  resources :users, only: %i[show edit update destroy] do
    member do
      get 'keeps'
    end
  end

  resources :comics do
    resource :keeps, only: %i[create destroy]
    collection do
      get 'search'
      get 'sort'
    end
  end
end
