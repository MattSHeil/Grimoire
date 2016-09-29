class UsersController < ApplicationController
	before_action :authenticate_user!, only: :show

	def show
		@user = User.find(params[:id])
		@mangas = @user.mangas
		render 'users/show'
	end
	
end
