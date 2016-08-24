class MangasController < ApplicationController

	protect_from_forgery with: :null_session

	def index
		manga_list = Manga.all
		render json: manga_list 
	end

	def create
		newManga = Manga.create(mangaParams)
		render json: newManga 
	end

	def show
		theManga = Manga.find_by(id: params[:id])
		unless theManga
			render json: {error: "Manga doesn't exist yet"},
				status: 404
			return
		end
		render json: theManga
	end

	def update
		theManga = Manga.find_by(id: params[:id])
		unless theManga
			render json: {error: "Manga doesn't exist yet"},
				status: 404
			return
		end
		theManga.update(mangaParams)
		render json: theManga
	end

	def delete
	end

	private

	def mangaParams
		params.require(:manga).permit(:title, :link_to_page, :total_chapters, :last_chapter, :posted_date)
	end
end
