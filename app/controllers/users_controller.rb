class UsersController < ApplicationController
	before_action :authenticate_user!, only: :show

	def show
		@user = current_user
		@mangas = @user.mangas
		
		@latests_mangas = []
 		@imgSrc = ""
		
		UserManga.where(user_id: current_user.id).each do | singleUserManga |
			if singleUserManga.updated == true
				print singleUserManga
				mangaObj = Manga.find_by(id: singleUserManga.manga_id)
				@latests_mangas.push(mangaObj)
			end
 		end

	end
		# render 'users/show'
end
