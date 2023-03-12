Rails.application.routes.draw do
  devise_for :users
  root to: "tickets#index"
  resources :tickets, only: [:create, :destroy] do
    collection do
      get :day_recap, as: :recap
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
