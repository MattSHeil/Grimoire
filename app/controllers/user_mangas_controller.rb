class UserMangasController < ApplicationController
	def add_manga
		user = current_user
		manga = Manga.find_by(id: params[:id])
		user.mangas.push(manga)
	end

	def delete_manga
		user = current_user
		manga = Manga.find_by(id: params[:id])
		user.mangas.destroy(manga)
	end
end
