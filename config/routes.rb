Rails.application.routes.draw do
  resources :charges, only: [:new, :create, :destroy]
  resources :wikis do
    resources :collaborators
  end
  devise_for :users
  get 'about' => 'welcome#about'

  root to: 'welcome#index'
end