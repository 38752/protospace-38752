Rails.application.routes.draw do
  devise_for :users
  resources :prototypes do
    # collection do
    #   get 'notexist'
    # end
    # member do
    #   resources :comments, only: :create
    # end
    resources :comments, only: :create
  end
  resources :users, only: :show
  root "prototypes#index"
end
