class Author < ApplicationRecord
	has_many :mangas_authors
	has_many :mangas, through: :mangas_authors
end
