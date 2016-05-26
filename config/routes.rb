Rails.application.routes.draw do

  get 'repos/remove/:id' => 'repos#remove', as: :repo_remove
  get 'repos/new/:github_id' => 'repos#new', as: :new_repo
  get 'repos/github' => 'repos#github_repos', as: :github_repos

  resources :repos

  devise_for :admins
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  root 'pages#home'
end
