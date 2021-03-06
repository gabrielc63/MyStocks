Rails.application.routes.draw do
  resources :user_stocks, only: %i[create destroy]
  devise_for :users
  root :to => 'welcome#index'
  get 'welcome/index'
  get 'my_portfolio', to: 'users#my_portfolio'
  get 'search_stock', to: 'stocks#search'
  resources :stocks
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
