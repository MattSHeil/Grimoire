Rails.application.routes.draw do
  root to: 'static_pages#home'
  devise_for :users
  get '/user/:id', to: 'users#show', as: :user_page
  
  # API request routes
  get '/advanced', to: 'api/mangas#advanced', as: :api_advanced_search_manga

  # Route to be used if api request is necessary, if make it into gem for example
  # get '/search/:keyword', to: "api/mangas#search", as: :api_search_manga

  # add and delete routes for users mangas
  post '/mangas/:id/add', to: 'user_mangas#add_manga', as: :add_manga_to_user
  delete '/mangas/:id/delete', to: 'user_mangas#delete_manga', as: :delete_manga_from_user
  put '/user/mangas/read', to: 'user_mangas#read', as: :update_read_user_manga

  namespace :api do 
    resources :mangas
  end

  scope module: "views" do 
    resources :mangas 
  end
  
  # Search MangaRoute
  get '/search', to: 'views/mangas#search', as: :views_search_manga

end
