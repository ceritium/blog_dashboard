BlogDashboard::Engine.routes.draw do

  mount RedactorRails::Engine => '/redactor_rails'

  match "/" => "posts#index", as: :blog_dashboard_root
  resources :posts
  resources :categories
  resources :comments
end
