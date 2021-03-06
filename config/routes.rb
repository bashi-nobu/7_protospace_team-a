Rails.application.routes.draw do
  devise_for :users
  root 'prototypes#index'

  resources :prototypes, only: [:index, :new, :create, :show, :edit, :update, :destroy] do
    resources :comments, only: [:create, :edit, :update, :destroy]
  end
  resources :users, only: [:show, :edit, :update]
  resources :category, only: [:index,:show]
end
