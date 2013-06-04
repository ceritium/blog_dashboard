BlogDashboard::Engine.routes.draw do


  match "/" => "posts#index", as: :blog_dashboard_root
  resources :posts
  resources :categories
  resources :comments

  if BlogDashboard::configuration.demo_blog
    namespace :demo do
      root to: "posts#index"
      resources :posts  do
        post 'create_comment', on: :member
      end
    end
  end
end
