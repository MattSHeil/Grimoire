class StaticPagesController < ApplicationController
	def home
		@labels = Label.all
	end
end
