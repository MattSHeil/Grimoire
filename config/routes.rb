Rails.application.routes.draw do
  resources :mangas, except: [:new, :edit]
end
