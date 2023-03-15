Rails.application.routes.draw do
  devise_for :users
  root to: "tickets#index"
  resources :tickets, only: [:create, :destroy] do
    collection do
      get :day_recap, as: :recap
    end
  end
  resources :homeworks, only: [:index, :new, :create, :edit, :update, :destroy] do
    member do
      get :grade
    end
  end
end
