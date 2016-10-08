class StaticPagesController < ApplicationController
	def home
		@manga = Manga.new
		if params[:search]
			@manga = Manga.search(params[:search]).order("updated_at DESC")
		else
			@manga = "Something went wrong"
		end

		@latests = Manga.latests
	end
end
