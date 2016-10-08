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

	def read
		user = current_user
		mangas = UserManga.where(user_id: current_user.id)
		mangas.where(manga_id: params[:id]).update(updated: false)
	end
end
