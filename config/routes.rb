Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions' }
  resources :users, except: :create

  # Name it however you want
  post 'create_user' => 'users#create', as: :create_user


  root 'boards#index'

  resources :boards do
    resources :columns do
    end
    resources :tasks do
      resources :action_items
    end
  end
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
