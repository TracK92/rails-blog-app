Rails.application.routes.draw do
  devise_for :users, sign_out_via: %i[get post]
  devise_scope :user do
    get 'sign_out', to: 'devise/sessions#destroy'
  end
  root to: "users#index"

  resources :users, only: [:index, :show] do
    resources :posts do
      resources :comments
      resources :likes, only: [:new, :create]
    end
  end
end
