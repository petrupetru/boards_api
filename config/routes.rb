Rails.application.routes.draw do
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
