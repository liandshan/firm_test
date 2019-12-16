Rails.application.routes.draw do
  resources :orders
  resources :products
  resources :users

  get 'category_report', to: 'orders#category_report'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
