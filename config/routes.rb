Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'customers#index'
  resources :customers
  resources :payments do
    collection do
      get 'success'
      get 'cancel'
    end
  end
  get '/delete_customer', to: 'customers#delete'   
end
