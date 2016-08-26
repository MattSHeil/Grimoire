class Manga < ApplicationRecord
	validates :title, uniqueness: true 

	has_many :labeled_mangas
	has_many :labels, through: :labeled_mangas
end
