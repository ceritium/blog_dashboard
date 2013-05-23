BlogDashboard::Engine.routes.draw do


  match "/" => "posts#index", as: :blog_dashboard_root
  resources :posts
  resources :categories
  resources :comments
end
