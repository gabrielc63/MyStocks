Rails.application.routes.draw do
  resources :user_stocks, only: %i[create destroy]
  devise_for :users
  resources :stocks
  resources :users, only: [:show]
  resources :friendships

  root to: 'welcome#index'
  get 'welcome/index'
  get 'my_portfolio', to: 'users#my_portfolio'
  get 'search_stock', to: 'stocks#search'
  get 'my_friends', to: 'users#my_friends'
  get 'search_friends', to: 'users#search'
  post 'add_friend', to: 'users#add_friend'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
