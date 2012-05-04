Rails.application.routes.draw do
  devise_for :users
  root :to => 'home#index'

  mount Blog::Engine => "/blog"
end
