Rails.application.routes.draw do

  devise_for :users
  mount BlogDashboard::Engine => "/admin"
  resources :posts
end
