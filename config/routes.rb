Rails.application.routes.draw do
  root to: "static_pages#home"
  devise_for :users
  get '/user/:id', to: 'users#show', as: :user_page
  resources :mangas, except: [:new, :edit]
  get '/search', to: 'mangas#search', as: :search_manga

  # API request routes
  get "/mangas/search/:keyword", to: "mangas#searchLabel"
  get "/mangas/list/:keyword", to: "mangas#searchName"
end
