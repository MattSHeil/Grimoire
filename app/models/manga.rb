class Manga < ApplicationRecord
	validates :title, uniqueness: true 

	has_many :labeled_mangas
	has_many :labels, through: :labeled_mangas

	has_many :mangas_authors
	has_many :authors, through: :mangas_authors

	has_many :mangas_artists
	has_many :artists, through: :mangas_artists

	has_many :user_mangas
	has_many :users, through: :user_mangas
end
