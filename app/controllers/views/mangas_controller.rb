class Views::MangasController < ApplicationController
	def show
		@manga = Manga.find_by(id: params[:id])
		@author = @manga.authors
		@artist = @manga.artists
		@img = @manga.manga_img.cover_img_url 
	end

	def search
        @result = Manga.search(params[:keyword])
	end
end
