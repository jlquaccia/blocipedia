Rails.application.routes.draw do
  resources :charges, only: [:new, :create, :destroy]
  resources :wikis do
    resources :collaborators
  end
  devise_for :users
  resources :users, only: [:update]

  get 'about' => 'welcome#about'

  root to: 'welcome#index'
end