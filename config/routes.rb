Rails.application.routes.draw do
  root to: "static_pages#home"
  resources :mangas, except: [:new, :edit]
end
