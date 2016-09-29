class Api::MangasController < ApplicationController
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

	def advanced
		@user = current_user
		@searchableLabels = Label.all
	end

	#might need it if api routes change
	# def search
 # 		@result = if (params[:keyword]).length == 1 
	# 	     	 	Manga.where("title iLIKE ?" , "#{params[:keyword]}%")
	# 		 	else
	# 				Manga.where("lower(title) iLIKE ?", "%#{params[:keyword].downcase}%")
	# 			end
	# 			unless @result
	# 			 	render json: {error: "Manga search problem ..."},
	# 			 	 	status: 404
	# 			    return
	# 			end
	# 	render json: @result
	# end

	private

	def mangaParams
		params.require(:manga).permit(:title, :link_to_page, :total_chapters, :last_chapter, :posted_date)
	end
end

#to be implemented later
# def labelSearch	
	# result = Label.find_by(name: params[:keyword].capitalize)
	# unless result
	# 	render json: {error: "Opps genre problem, try again ..."},
	# 		status: 404
	# 	return
	# end	
	# render json: result.mangas
# end
