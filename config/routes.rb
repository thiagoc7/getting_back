Rails.application.routes.draw do
  resources :books do
    resources :chapters
  end
  root "books#index"
end
