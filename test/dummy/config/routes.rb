Rails.application.routes.draw do


  root to: "welcome#index"
  devise_for :users
  mount BlogDashboard::Engine => "/admin"
  mount RedactorRails::Engine => '/redactor_rails'

end
