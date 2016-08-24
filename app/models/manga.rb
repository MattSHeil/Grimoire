class Manga < ApplicationRecord
	validates :title, uniqueness: true 
end
