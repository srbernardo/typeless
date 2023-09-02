Rails.application.routes.draw do
  get 'search', to: 'search#index'
  devise_for :users
  root to: "pages#home"
  resources :expenses
  resources :incomes
  get "", to: "pages#new"
  post "", to: "pages#create"
end
