Rails.application.routes.draw do

  devise_for :admins
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  root 'pages#home'
end
