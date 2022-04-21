Rails.application.routes.draw do
  get 'categories/show'
  get 'categories/new'
  get 'categories/index'
  get 'categories/edit'
  get 'categories/update'
  get 'categories/create'
  get 'categories/destroy'
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
end
