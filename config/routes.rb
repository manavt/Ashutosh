Rails.application.routes.draw do
  resources :products do
    collection do
      get "download_in_csv"
    end
    member do
    end
  end
  # resources :payments do
  #   get 'process_payment'
  # end
  get "payments/process_payment"
  post "payments/call_braintree"
  # resources :payments do
  #   collection do
  #     get "process_payment"
  #     post "call_braintree"
  #   end
  #   # member do
  #    get "payment_history", on: :member
  #   # end
  # end
  #get "hello/:location/:name", to: "payments#payment_history"
  resources :users do
   collection do
     get 'login'
     post 'authenticate'
     delete 'logout'
   end
  end
  namespace :api do
    resources :users
  end
  get "/registration", to: 'users#new'
  get 'auth/:provider/callback', to: 'users#facebook'
  root to: "users#login"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
