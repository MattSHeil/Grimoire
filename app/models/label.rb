class Label < ApplicationRecord
	has_many :labeled_mangas
	has_many :mangas, through: :labeled_mangas
end
