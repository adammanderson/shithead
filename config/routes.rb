Rails.application.routes.draw do
  mount ActionCable.server, at: '/cable'

  root to: 'app#index'
  get 'rooms/:slug', to: 'app#index'

  resource :game, only: :show

  resources :login, only: [:create, :destroy]
end
