class MangasArtist < ApplicationRecord
	belongs_to :manga
	belongs_to :artist
end
