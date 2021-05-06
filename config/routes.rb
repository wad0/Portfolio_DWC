Rails.application.routes.draw do
  get 'homes/top'
  get 'homes/about'
  devise_for :users
  root to:'homes#top'
end
