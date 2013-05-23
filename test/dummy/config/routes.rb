Rails.application.routes.draw do

  devise_for :users
  mount BlogDashboard::Engine => "/admin"
  mount RedactorRails::Engine => '/redactor_rails'
  resources :posts
end
