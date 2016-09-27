Rails.application.routes.draw do
  root to: "static_pages#home"
  devise_for :users
  get '/user/:id', to: 'users#show', as: :user_page
  # resources :mangas, except: [:new, :edit]
  get '/search', to: 'api/mangas#search', as: :search_manga

  namespace :api do 
  	resources :mangas
  end

  scope module: "views" do 
  	resources :mangas 
  end

  # API request routes
  get "/mangas/search/:keyword", to: "api/mangas#searchLabel"
  get "/mangas/list/:keyword", to: "api/mangas#searchName"
end
