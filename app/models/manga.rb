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

	has_one :manga_img

	def self.search(params)
		if (params).length == 1 
	 		where("title iLIKE ?" , "#{params}%")
	 	else
			where("lower(title) iLIKE ?", "%#{params.downcase}%")
		end
	end

	def self.latests
		order(updated_at: :desc).limit(50)
	end
end
