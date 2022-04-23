Rails.application.routes.draw do
  # get 'reports/index'
  # get 'reports/show'
  namespace :api do
    namespace :v1 do
      resources :menus
      resources :categories
      resources :orders
      get '/reports/index', to: 'reports#index'
      patch '/orders/:id/cancel', to: 'orders#canceled'
      patch '/orders/:id/paid', to: 'orders#paid'
    end
  end
  # get 'orders/show'
  # get 'orders/index'
  # get 'orders/new'
  # get 'orders/edit'
  # get 'categories/show'
  # get 'categories/new'
  # get 'categories/index'
  # get 'categories/edit'
  # get 'categories/update'
  # get 'categories/create'
  # get 'categories/destroy'
  # get 'menus/index'
  # get 'menus/new'
  # get 'menus/edit'
  # get 'menus/update'
  # get 'menus/show'
  # get 'menus/destroy'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :menus
  resources :categories
  resources :orders
  resources :reports
end
