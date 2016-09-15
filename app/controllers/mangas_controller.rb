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

	def searchLabel
		result = Label.find_by(name: params[:keyword].capitalize)
		unless result
			render json: {error: "Opps genre problem, try again ..."},
				status: 404
			return
		end	
		render json: result.mangas
	end

	def searchName
       result = if (params[:keyword]).length == 1 
		     	 	Manga.where("title iLIKE ?" , "#{params[:keyword]}%")
			 	else
					Manga.where("lower(title) = ?", params[:keyword].downcase)
				end
				unless result
				 	render json: {error: "Manga doesn't exist yet"},
				 	 	status: 404
				    return
				end
		render json: result
	end

	def search
		@user = current_user
		@searchableLabels = Label.all
	end

	private

	def mangaParams
		params.require(:manga).permit(:title, :link_to_page, :total_chapters, :last_chapter, :posted_date)
	end
end
