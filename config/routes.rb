Rails.application.routes.draw do
  get '/', to: 'searches#new', as: 'new_search'
  post 'searches', to: 'searches#create', as: 'searches'
  get 'analytics', to: 'analytics#index'
  post 'analytics/reset', to: 'analytics#reset', as: 'reset_analytics'
end
