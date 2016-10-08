class StaticPagesController < ApplicationController
	def home
		@manga = Manga.all
		if params[:search]
			@manga = Manga.search(params[:search]).order("updated_at DESC")
		else
			@manga = "Something went wrong"
		end

		@latests = Manga.latests

		# begin
		# 	open(.manga_img.cover_img_url)
		# rescue => error
		# 	if error
		# 		@img = "https://dummyimage.com/200x310"
		# 	else
		# 		@img = @manga.manga_img.cover_img_url
		# 	end
		# end

		# if user_signed_in?
		# 	redirect_to "/user/#{current_user.id}"
		# end
	end
end
