Rails.application.routes.draw do

  devise_for :users
  mount BlogDashboard::Engine => "/admin"
  mount RedactorRails::Engine => '/redactor_rails'

  scope '/blog' do
    root to: 'posts#index'
    resources :posts do
      post 'create_comment', on: :member
    end
  end
end
