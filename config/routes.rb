Rails.application.routes.draw do
  root to: 'members#index'

  resources :members do
    member do
      get :profile
    end
  end

  get 'website/:key', to: 'members#redirect_to_website', as: :member_website
end
