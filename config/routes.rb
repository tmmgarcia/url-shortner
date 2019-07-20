Rails.application.routes.draw do
  root to: 'short_uris#index'

  resources :short_uris, only: [:index, :new, :create, :show]
  get '/:path', to: 'short_uris#path'
end
