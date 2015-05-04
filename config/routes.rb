Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  devise_for :users
  resources :registered_applications
  # You can have the root of your site routed with "root"
    root to: 'welcome#index'
  
#API routes
  namespace :api, defaults: { format: :json } do
    resources :events, only: [:create]
  end
  
end
