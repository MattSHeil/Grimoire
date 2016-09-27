class StaticPagesController < ApplicationController
	def home
		@manga = Manga.all
		if params[:search]
			@manga = Manga.search(params[:search]).order("updated_at DESC")
		else
			@manga = "Something went wrong"
		end

		@latests = Manga.latests

		# if user_signed_in?
		# 	redirect_to "/user/#{current_user.id}"
		# end
	end
end
