class Views::MangasController < ApplicationController
	def show
		@manga = Manga.find_by(id: params[:id])
		@author = @manga.authors
		@artist = @manga.artists
	end
end
