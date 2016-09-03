class Artist < ApplicationRecord
	has_many :mangas_artists
	has_many :mangas, through: :mangas_artists
end
